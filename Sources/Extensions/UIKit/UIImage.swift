//
//  UIImage.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension UIImage {
    /// Gets avarage color of the image.
    public var averageColor: UIColor? {
        guard let imageData = self.cgImage?.dataProvider?.data,
            let dataPointer = CFDataGetBytePtr(imageData) else {
            return nil
        }

        let precision = 10
        let wideStride = stride(from: 0, to: Int(size.width), by: precision)
        var numberOfItems: CGFloat = 0
        let colorComponents: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = wideStride
            .map { x in
                defer {
                    numberOfItems += 1
                }
                return pixelInfo(data: dataPointer, x: x, y: 0, width: size.width)
            }
            .reduce((0.0, 0.0, 0.0, 0.0), { (res: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat), nxt: (r: UInt8, g: UInt8, b: UInt8, a: UInt8)) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) in
                (res.r + CGFloat(nxt.r),
                 res.g + CGFloat(nxt.g),
                 res.b + CGFloat(nxt.b),
                 res.a + CGFloat(nxt.a))
            })

        return UIColor(
            red: (colorComponents.r / numberOfItems) / 255.0,
            green: (colorComponents.g / numberOfItems) / 255.0,
            blue: (colorComponents.b / numberOfItems) / 255.0,
            alpha: (colorComponents.a / numberOfItems) / 255.0
        )
    }

    private func pixelInfo(data: UnsafePointer<UInt8>, x: Int, y: Int, width: CGFloat) -> (r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        let pos = ((Int(round(width)) * y) + x) * 4

        return (data.advanced(by: pos + 0).pointee,
                data.advanced(by: pos + 1).pointee,
                data.advanced(by: pos + 2).pointee,
                data.advanced(by: pos + 3).pointee)
    }
}

public extension UIImage {
    /// Creates UIImage of given size filled with given color.
    ///
    /// - Parameters:
    ///   - color: Given color.
    ///   - size: Given size.
    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.init(cgImage: image!.cgImage!)
    }
}

public extension UIImage {
    /// Size in bytes of UIImage.
    public var bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }

    /// Size in kilo bytes of UIImage.
    public var kilobytesSize: Int {
        return bytesSize / 1024
    }

    /// UIImage with .alwaysOriginal rendering mode.
    public var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    /// UIImage with .alwaysTemplate rendering mode.
    public var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}

// MARK: - Methods

public extension UIImage {
    /// Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    public func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    public func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }

    /// UIImage cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    public func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width < size.width && rect.size.height < size.height else { return self }
        guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
        return UIImage(cgImage: image)
    }

    /// UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: New height.
    ///   - opaque: Flag indicating whether the bitmap is opaque.
    /// - Returns: Optional scaled UIImage (if applicable).
    public func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / size.height
        let newWidth = size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, 0)
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: New width.
    ///   - opaque: Flag indicating whether the bitmap is opaque.
    /// - Returns: Optional scaled UIImage (if applicable).
    public func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, 0)
        draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// Creates a copy of the receiver rotated by the given angle.
    ///
    /// - Parameter angle: The angle measurement by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    public func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)

        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// Creates a copy of the receiver rotated by the given angle (in radians).
    ///
    /// - Parameter radians: The angle, in radians, by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    public func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())

        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }

        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)

        draw(in: CGRect(origin: CGPoint(x: -size.width / 2,
                                        y: -size.height / 2),
                        size: size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// UIImage filled with color.
    ///
    /// - Parameter color: Color to fill image with.
    /// - Returns: UIImage filled with given color.
    public func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let mask = self.cgImage else { return self }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// UIImage tinted with color.
    ///
    /// - Parameters:
    ///   - color: Color to tint image with.
    ///   - blendMode: How to blend the tint.
    /// - Returns: UIImage tinted with given color.
    public func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context!.clip(to: drawRect, mask: cgImage!)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }

    /// UIImage with rounded corners.
    ///
    /// - Parameter radius: Corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
