import UIKit

class CustomButtonView: UIView {
    
    private var typeFill: Bool = true {
        didSet {
            applyStyle()
        }
    }
    
    private lazy var customBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private var nextPageAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func getNextPage() {
        nextPageAction?()
    }

    func configure(title: String, typeFill: Bool, nextPage: @escaping () -> Void) {
        customBtn.setTitle(title, for: .normal)
        self.typeFill = typeFill
        nextPageAction = nextPage
        
        customBtn.addTarget(self, action: #selector(getNextPage), for: .touchUpInside)
    }
    
    private func applyStyle() {
        customBtn.setTitleColor(typeFill ? .white : .brandClr, for: .normal)
        customBtn.backgroundColor = typeFill ? .brandClr : .clear
        customBtn.layer.borderWidth = typeFill ? 0 : 1
        customBtn.layer.borderColor = UIColor.brandClr.cgColor
    }

    private func setupUI() {
        addSubview(customBtn)
    }
    
    private func setupConstrains() {
        customBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBtn.topAnchor.constraint(equalTo: topAnchor),
            customBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            customBtn.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBtn.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
