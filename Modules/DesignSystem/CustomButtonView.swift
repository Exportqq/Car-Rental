import UIKit

class CustomButtonView: UIView {
    
    private var typeFill: Bool = true
    
    private lazy var сustomBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = typeFill ? .brandClr : .clear
        button.layer.cornerRadius = 12
        button.layer.borderWidth = typeFill ? 0 : 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    private var nextPageAction: (() -> Void)?

    @objc private func getNextPage() {
        nextPageAction?()
    }

    func configure(title: String, typeFill: Bool, nextPage: @escaping () -> Void) {
        сustomBtn.setTitle(title, for: .normal)
        self.typeFill = typeFill
        nextPageAction = nextPage
        сustomBtn.addTarget(self, action: #selector(getNextPage), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(сustomBtn)
    }
    
    
    private func setupConstrains() {
        [сustomBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            сustomBtn.topAnchor.constraint(equalTo: self.topAnchor),
            сustomBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            сustomBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            сustomBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            сustomBtn.heightAnchor.constraint(equalToConstant: 56),

        ])
    }
}
