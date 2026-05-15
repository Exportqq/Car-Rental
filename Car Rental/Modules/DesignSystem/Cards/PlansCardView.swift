import UIKit

class PlansCardView: UIView {
    
    private let cardBackground: UIView = {
        let background = UIView()
        background.backgroundColor = .clear
        background.layer.borderColor = UIColor.disabled.cgColor
        background.layer.borderWidth = 1
        background.layer.cornerRadius = 20
        return background
    }()
    
    private let cardPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = .disabled
        view.layer.cornerRadius = 18
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let cardPlacIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cardPlanPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 12)
        label.textColor = .disabled
        return label
    }()
    
    private lazy var priceViewStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardPlacIcon, cardPlanPrice])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let cardTypeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = .disabled
        return label
    }()
    
    private let cardTypeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = .disabled
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardTypeTitle, cardTypeText])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
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
        addSubview(cardPriceView)
        cardPriceView.addSubview(priceViewStack)
        cardBackground.addSubview(textStack)
    }
    
    func setSelected(_ isSelected: Bool) {
        let borderWidth: CGFloat = isSelected ? 2 : 0
        
        UIView.animate(withDuration: 0.2) {
//            self.card.layer.borderWidth = borderWidth
        }
        
//        card.layer.borderColor = UIColor.brandClr.cgColor
    }
    
    private func setupConstrains() {
        [cardBackground, cardPriceView, priceViewStack, textStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cardBackground.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardBackground.heightAnchor.constraint(equalTo: self.heightAnchor),
            cardBackground.widthAnchor.constraint(equalTo: self.widthAnchor),
          
            cardPriceView.topAnchor.constraint(equalTo: cardBackground.topAnchor),
            cardPriceView.bottomAnchor.constraint(equalTo: cardBackground.bottomAnchor),
            cardPriceView.leadingAnchor.constraint(equalTo: cardBackground.leadingAnchor),
            cardPriceView.widthAnchor.constraint(equalToConstant: 44),
            
            priceViewStack.centerXAnchor.constraint(equalTo: cardPriceView.centerXAnchor),
            priceViewStack.centerYAnchor.constraint(equalTo: cardPriceView.centerYAnchor),
            
            textStack.centerYAnchor.constraint(equalTo: cardBackground.centerYAnchor),
            textStack.leadingAnchor.constraint(equalTo: cardPriceView.leadingAnchor, constant: 8),
        ])
    }
    
    func configure(icon: UIImage, price: String, title: String, text: String) {
        cardPlacIcon.image = icon
        cardPlanPrice.text = price
        cardTypeTitle.text = title
        cardTypeText.text = text
    }
}

