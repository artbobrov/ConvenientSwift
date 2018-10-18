import ConvenientSwift
import UIKit

func example(name: String, _ block: () -> Void) {
    print("$ example: \(name)")
    block()
    print("------------ end ------------")
}

example(name: "create") {
    let view: UIView = create { view in
        view.layer.cornerRadius = 5
    }
    print("view corner radius: \(view.layer.cornerRadius)")
}

example(name: "then") {
    let point: CGPoint = .zero
    point.with { p in
        p.x = 5
        p.y = 5
    }
    print("point changed using `with`: \(point)")
    let view = UIView().then { view in
        view.layer.cornerRadius = 5
    }

    print("view corner radius: \(view.layer.cornerRadius)")
}

example(name: "never example") {
    let optionalValue: Int? = nil
    let nonoptional: Int = optionalValue ?? fatalError("nil value") // error here because optionalValue is nil
    print(nonoptional)
}
