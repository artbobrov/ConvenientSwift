import ConvenientSwift
import UIKit

func example(name: String, _ block: () -> Void) {
    print("$ example: \(name)")
    block()
    print("------------ end ------------")
	print()
}

example(name: "Create") {
    let view: UIView = create { view in
        view.layer.cornerRadius = 5
    }
    print("view corner radius: \(view.layer.cornerRadius)")
}

example(name: "Then") {
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

example(name: "Never") {
    let optionalValue: Int? = 5
    let nonoptional: Int = optionalValue ?? fatalError("nil value") // error here because optionalValue is nil
    print(nonoptional)
}

struct Person: Change {
	var name: String
	var age: Int
}

example(name: "Change") {
	let person = Person(name: "John", age: 4)
	print("person: \(person.change(key: \.name, with: "Tim").change(key: \.age, with: 22))")

	let view = UIView().change(key: \.frame, with: CGRect(x: 100, y: 100, width: 222, height: 222))
	print("view's frame: \(view.frame)")

}
