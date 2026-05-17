import UIKit

class PlansCardView: UIView {
    
    private var priceLeadingConstraint: NSLayoutConstraint!
    private var priceHeightConstraint: NSLayoutConstraint!
    private var priceTopConstraint: NSLayoutConstraint!
    
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
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
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
        label.textColor = .textGrey
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
        label.textColor = .textGrey
        return label
    }()
    
    private let cardTypeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = .textGreyLigth
        label.numberOfLines = 0
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
        
        priceLeadingConstraint.constant = isSelected ? 2 : 1
        priceHeightConstraint.constant = isSelected ? 76 : 78
        priceTopConstraint.constant = isSelected ? 2 : 1
            
        UIView.animate(withDuration: 0.2) {
            
            self.cardBackground.layer.borderWidth = isSelected ? 2 : 1
            
            self.cardBackground.layer.borderColor = isSelected
            ? UIColor.brandClr.cgColor
            : UIColor.textGrey.cgColor
            
            self.cardPriceView.backgroundColor = isSelected
            ? .lightBrandClr
            : .disabled
            
            self.cardPlacIcon.tintColor = isSelected
            ? .brandClr
            : .disabled
            
            self.cardPlanPrice.textColor = isSelected
            ? .brandClr
            : .textGrey
            
            self.cardTypeTitle.textColor = isSelected
            ? .textBlack
            : .textGrey
            
            self.cardTypeText.textColor = isSelected
            ? .textGrey
            : .textGreyLigth
            
            self.layoutIfNeeded()
        }
    }
    
    private func setupConstrains() {
        [cardBackground, cardPriceView, priceViewStack, textStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        priceLeadingConstraint = cardPriceView.leadingAnchor.constraint(
            equalTo: cardBackground.leadingAnchor,
            constant: 1
        )

        priceHeightConstraint = cardPriceView.heightAnchor.constraint(
            equalToConstant: 78
        )
        
        priceTopConstraint = cardPriceView.topAnchor.constraint(
            equalTo: cardBackground.topAnchor,
            constant: 1
        )
        
        NSLayoutConstraint.activate([
            cardBackground.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardBackground.heightAnchor.constraint(equalTo: self.heightAnchor),
            cardBackground.widthAnchor.constraint(equalTo: self.widthAnchor),
           
            cardPriceView.widthAnchor.constraint(equalToConstant: 44),
            priceLeadingConstraint,
            priceHeightConstraint,
            priceTopConstraint,
            
            priceViewStack.centerXAnchor.constraint(equalTo: cardPriceView.centerXAnchor),
            priceViewStack.centerYAnchor.constraint(equalTo: cardPriceView.centerYAnchor),
            
            textStack.centerYAnchor.constraint(equalTo: cardBackground.centerYAnchor),
            textStack.leadingAnchor.constraint(equalTo: cardPriceView.trailingAnchor, constant: 8),
            
            cardTypeText.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(icon: UIImage?, price: String, title: String, text: String) {
        cardPlacIcon.image = icon
        cardPlanPrice.text = price
        cardTypeTitle.text = title
        cardTypeText.text = text
    }
}

