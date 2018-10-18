//
//  UIImageView.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension UIImageView {
    /// Returns image scale.
    public var imageScale: CGSize {
        if let image = self.image {
            let sx = Double(frame.size.width / image.size.width)
            let sy = Double(frame.size.height / image.size.height)
            var s = 1.0
            switch contentMode {
            case .scaleAspectFit:
                s = fmin(sx, sy)
                return CGSize(width: s, height: s)

            case .scaleAspectFill:
                s = fmax(sx, sy)
                return CGSize(width: s, height: s)

            case .scaleToFill:
                return CGSize(width: sx, height: sy)

            default:
                return CGSize(width: s, height: s)
            }
        }

        return CGSize.zero
    }

    /// Returns real image size.
    public var realImageSize: CGSize {
        guard let image = self.image else { return .zero }
        let scale = imageScale
        return CGSize(width: image.size.width * scale.width, height: image.size.height * scale.height)
    }
}

public extension UIImageView {
    /// Set image from a URL.
    ///
    /// - Parameters:
    ///   - url: URL of image.
    ///   - contentMode: UIImageView content mode (default is .scaleAspectFit).
    ///   - placeHolder: Optional placeholder image
    ///   - completionHandler: Optional completion handler to run when download finishs (default is nil).
    public func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil
    ) {
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
            else {
                completionHandler?(nil)
                return
            }
            DispatchQueue.main.async {
                self.image = image
                completionHandler?(image)
            }
        }.resume()
    }

    /// Make image view blurry.
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    public func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }

    /// Blurred version of an image view.
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    /// - Returns: Blurred version of self.
    public func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}
