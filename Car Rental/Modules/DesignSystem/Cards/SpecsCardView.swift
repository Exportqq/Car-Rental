import UIKit

class SpecsCardView: UIView {
    
    private let cardBackground: UIView = {
        let background = UIView()
        background.backgroundColor = .clear
        background.layer.borderColor = UIColor.textGrey.cgColor
        background.layer.borderWidth = 1
        background.layer.cornerRadius = 10
        return background
    }()
    
    private let specName: UILabel = {
        let label = UILabel()
        label.textColor = .textBlack
        label.font = UIFont(name: "Roboto-Bold", size: 12)
        return label
    }()
    
    private let specInfo: UILabel = {
        let label = UILabel()
        label.textColor = .textBlack
        label.font = UIFont(name: "Roboto-Light", size: 12)
        return label
    }()
    
    private lazy var specsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [specName, specInfo])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(cardBackground)
        addSubview(specsStack)
    }
    
    private func setupConstrains() {
        [cardBackground, specsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cardBackground.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardBackground.heightAnchor.constraint(equalTo: self.heightAnchor),
            cardBackground.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            specsStack.centerYAnchor.constraint(equalTo: cardBackground.centerYAnchor),
            specsStack.leadingAnchor.constraint(equalTo: cardBackground.leadingAnchor, constant: 8)
        ])
    }
    
    func configure(name: String, info: String) {
        specName.text = name
        specInfo.text = info
    }
}

