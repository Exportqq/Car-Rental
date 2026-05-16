import UIKit
import Kingfisher

class CarDetailHeaderView: UIView {
    
    var onBackTapped: (() -> Void)?
    
    private let backButton = BackButtonView()
    
    private let favoriteButton = FavoriteButtonView()
    
    private let carBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .backClr
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let carName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-SemiBold", size: 24)
        label.textColor = .textBlack
        label.text = "S 500 Sedan"
        return label
    }()
    
    private let raitingIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star")
        return img
    }()
    
    let carRaiting: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .textBlack
        label.text = "4.9"
        return label
    }()
    
    private lazy var raitingStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [raitingIcon, carRaiting])
        stackView.spacing = 6
        stackView.axis = .horizontal
        return stackView
    }()
    
    let carReviews: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = .textGrey
        label.text = "(230 Reviews)"
        return label
    }()
    
    private lazy var carFeedbackStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [raitingStack, carReviews])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var carInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carName, carFeedbackStack])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    let carImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test_mers")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, favoriteButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(carBackground)
        self.addSubview(buttonsStackView)
        self.addSubview(carInfoStack)
        self.addSubview(carImage)
    }
    
    private func setupConstrains() {
        [carBackground, carInfoStack, buttonsStackView, carImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [backButton, favoriteButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: 48).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        NSLayoutConstraint.activate([
            raitingIcon.heightAnchor.constraint(equalToConstant: 16),
            raitingIcon.widthAnchor.constraint(equalToConstant: 16),
            
            carBackground.topAnchor.constraint(equalTo: self.topAnchor),
            carBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            carBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            carBackground.heightAnchor.constraint(equalToConstant: 410),
            
            buttonsStackView.topAnchor.constraint(equalTo: carBackground.topAnchor, constant: 80),
            buttonsStackView.leadingAnchor.constraint(equalTo: carBackground.leadingAnchor, constant: 32),
            buttonsStackView.trailingAnchor.constraint(equalTo: carBackground.trailingAnchor, constant: -32),
            
            carInfoStack.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 16),
            carInfoStack.leadingAnchor.constraint(equalTo: carBackground.leadingAnchor, constant: 36),
            
            carImage.bottomAnchor.constraint(equalTo: carBackground.bottomAnchor),
            carImage.heightAnchor.constraint(equalToConstant: 272),
            carImage.widthAnchor.constraint(equalToConstant: 337),
            carImage.centerXAnchor.constraint(equalTo: carBackground.centerXAnchor),
        ])
    }
    
    func configure(name: String, raiting: Double, reviews: String, imageUrl: String) {
        carName.text = name
        carRaiting.text = "\(raiting)"
        carReviews.text = reviews
        
        if let url = URL(string: imageUrl) {
            carImage.kf.setImage(with: url)
        }
    }
    
    private func setupActions() {
        backButton.configure() { [weak self] in
            self?.onBackTapped?()
        }
    }
}

