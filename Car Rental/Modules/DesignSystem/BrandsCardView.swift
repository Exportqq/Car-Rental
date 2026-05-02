import UIKit
import Kingfisher

class BrandsCardView: UIView {
    
    private let cardBackground: UIView = {
        let background = UIView()
        background.backgroundColor = .white
        background.layer.cornerRadius = 20
        return background
    }()
    
    private let brandImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let brandName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .textBlack
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [brandImage, brandName])
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
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
        addSubview(mainStack)
    }
    
    private func setupConstrains() {
        [cardBackground, mainStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cardBackground.heightAnchor.constraint(equalToConstant: 94),
            cardBackground.widthAnchor.constraint(equalToConstant: 87),
            cardBackground.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            mainStack.centerYAnchor.constraint(equalTo: cardBackground.centerYAnchor),
            mainStack.centerXAnchor.constraint(equalTo: cardBackground.centerXAnchor),
        ])
    }
    
    func configure(image: String,brand: String) {
        if let url = URL(string: image) {
            brandImage.kf.setImage(with: url)
        }
        
        brandName.text = brand
    }
}

