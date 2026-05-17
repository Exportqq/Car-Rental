import UIKit

class CarDetailLocationView: UIView {
    
    var onPickUpTapped: (() -> Void)?
    
    private let locationTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Location"
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        return label
    }()
    
    private let locationView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.disabled.cgColor
        return view
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "location")
        return imageView
    }()
    
    private let locationName: UILabel = {
        let label = UILabel()
        label.textColor = .textBlack
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        return label
    }()
    
    private lazy var locationStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationIcon, locationName])
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let carPrice: UILabel = {
        let label = UILabel()
        label.textColor = .textBlack
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private let typePrice: UILabel = {
        let label = UILabel()
        label.textColor = .textGrey
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        return label
    }()
    
    private lazy var priceStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carPrice, typePrice])
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let pickUpButton = CustomButtonUIButton()

    private lazy var footerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceStack, pickUpButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
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
        addSubview(locationTitle)
        addSubview(locationView)
        locationView.addSubview(locationStack)
        addSubview(footerStack)
    }
    
    private func setupConstrains() {
        [locationTitle, locationView, locationIcon, locationStack, footerStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            locationTitle.topAnchor.constraint(equalTo: self.topAnchor),
            locationTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            locationView.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 16),
            locationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 40),
            
            locationIcon.heightAnchor.constraint(equalToConstant: 24),
            locationIcon.widthAnchor.constraint(equalToConstant: 24),
            
            locationStack.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 8),
            locationStack.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -8),
            locationStack.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            
            footerStack.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 22),
            footerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            footerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pickUpButton.heightAnchor.constraint(equalToConstant: 40),
            pickUpButton.widthAnchor.constraint(equalToConstant: 150),
    
        ])
    }
    
    func setupActions() {
        print("SETUP ACTIONS CALLED")
        
        pickUpButton.configure(title: "Pick Up", typeFill: true) { [weak self] in
            print("BUTTON CALLBACK FIRED")
            self?.onPickUpTapped?()
        }
    }
    
    func configure(location: String, price: Int, type: String) {
        locationName.text = location
        carPrice.text = "$\(price)"
        typePrice.text = type
    }

    func updatePrice(price: Int, type: String) {
        carPrice.text = "$\(price)"
        typePrice.text = type
    }
}

