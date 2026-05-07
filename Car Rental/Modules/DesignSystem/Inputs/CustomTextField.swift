import UIKit
import Combine

final class CustomTextField: UITextField {

    var padding = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 28
        backgroundColor = .clear
        textColor = .brandClr
        layer.borderColor = UIColor.brandClr.cgColor
        layer.borderWidth = 1
        font = UIFont(name: "Poppins-Regular", size: 16)
    }

    func configure(placeholder: String) {
        self.placeholder = placeholder
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
