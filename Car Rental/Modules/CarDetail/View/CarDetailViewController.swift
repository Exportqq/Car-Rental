import UIKit
import Kingfisher

class CarDetailViewController: UIViewController {
    private let carBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .backClr
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let carName: UILabel = {
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
    
    private let carRaiting: UILabel = {
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
    
    private let carReviews: UILabel = {
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
    
    private let carImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test_mers")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private let backButton = BackButtonView()
    
    private let favoriteButton = FavoriteButtonView()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, favoriteButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let specPower = SpecsCardView()
    private let specSpeed = SpecsCardView()
    private let specAcceleration = SpecsCardView()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true
        return scroll
    }()
    
    private lazy var specsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [specPower, specSpeed, specAcceleration])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()
    
    private let specTitle: UILabel = {
        let label = UILabel()
        label.text = "Specs"
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = .textBlack
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func SetupView() {
        
        view.addSubview(carBackground)
        view.addSubview(buttonsStackView)
        view.addSubview(carInfoStack)
        view.addSubview(carImage)
        view.addSubview(specTitle)
        
        view.addSubview(scrollView)
        scrollView.addSubview(specsStack)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)

    }
    
    private func SetupConstraints() {
        [carBackground, buttonsStackView,carInfoStack, carImage, specsStack, scrollView, specTitle].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [backButton, favoriteButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: 48).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        [specPower, specSpeed, specAcceleration].forEach {
            $0.widthAnchor.constraint(equalToConstant: 124).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        NSLayoutConstraint.activate([
            raitingIcon.heightAnchor.constraint(equalToConstant: 16),
            raitingIcon.widthAnchor.constraint(equalToConstant: 16),
            
            carBackground.topAnchor.constraint(equalTo: view.topAnchor),
            carBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
            
            specTitle.topAnchor.constraint(equalTo: carBackground.bottomAnchor, constant: 26),
            specTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            scrollView.topAnchor.constraint(equalTo: specTitle.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 48),

            specsStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            specsStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            specsStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            specsStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            specsStack.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
    
    func configure(name: String, raiting: Double, reviews: String, imageUrl: String, power: String, max_speed: String, acceleration: String) {
        carName.text = name
        carRaiting.text = "\(raiting)"
        carReviews.text = reviews
        
        if let url = URL(string: imageUrl) {
            carImage.kf.setImage(with: url)
        }
        
        specPower.configure(name: "Power", info: "\(power) hp @")
        specSpeed.configure(name: "Max speed", info: acceleration)
        specAcceleration.configure(name: "Acceleration", info: acceleration)

    }
    
    private func setupActions() {
        backButton.configure() { [weak self] in
            self?.pushBack()
        }
    }
    
    private func pushBack() {
        NavigationHelper.pop(from: self)
    }
}
