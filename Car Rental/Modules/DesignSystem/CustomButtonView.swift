import UIKit

final class CustomButtonUIButton: UIButton {
    
    private var typeFill: Bool = true {
        didSet {
            applyStyle()
        }
    }
    
    private var nextPageAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        applyStyle()
    }
    
    private func setup() {
        layer.cornerRadius = 12
        titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        nextPageAction?()
    }
    
    func configure(title: String, typeFill: Bool, action: @escaping () -> Void) {
        setTitle(title, for: .normal)
        self.typeFill = typeFill
        self.nextPageAction = action
    }
    
    private func applyStyle() {
        setTitleColor(typeFill ? .white : .brandClr, for: .normal)
        backgroundColor = typeFill ? .brandClr : .clear
        layer.borderWidth = typeFill ? 0 : 1
        layer.borderColor = UIColor.brandClr.cgColor
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
