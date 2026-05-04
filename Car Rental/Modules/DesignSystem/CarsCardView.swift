import UIKit
import Kingfisher

class CarsCardView: UIView {
    
    private let cardBackground: UIView = {
        let background = UIView()
        background.backgroundColor = .white
        background.layer.cornerRadius = 24
        background.layer.masksToBounds = true
        return background
    }()

    private let carName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.textColor = .textBlack
        return label
    }()
    
    private let carImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .textGrey
        return view
    }()
    
    private let carTransmission: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .textGrey
        return label
    }()
    
    private let carSeats: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .textGrey
        return label
    }()
    
    private let carFuel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .textGrey
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carTransmission, verticalLine, carSeats, verticalLine, carFuel])
        stackView.spacing = 12
        stackView.axis = .horizontal
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
        addSubview(carName)
        addSubview(infoStack)
    }
    
    private func setupConstrains() {
        [cardBackground, carName, infoStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            verticalLine.heightAnchor.constraint(equalToConstant: 18),
            verticalLine.widthAnchor.constraint(equalToConstant: 1),
            
            cardBackground.heightAnchor.constraint(equalToConstant: 171),
            cardBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardBackground.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            carName.topAnchor.constraint(equalTo: cardBackground.topAnchor, constant: 20),
            carName.leadingAnchor.constraint(equalTo: cardBackground.leadingAnchor, constant: 16),
            carName.widthAnchor.constraint(equalToConstant: 101),
            
            carImage.widthAnchor.constraint(equalToConstant: 203),
            carImage.heightAnchor.constraint(equalToConstant: 164),
            carImage.leadingAnchor.constraint(equalTo: carName.trailingAnchor, constant: 23),
            carImage.topAnchor.constraint(equalTo: cardBackground.topAnchor, constant: -73),
            
            infoStack.topAnchor.constraint(equalTo: carName.bottomAnchor, constant: 40),
            infoStack.centerXAnchor.constraint(equalTo: cardBackground.centerXAnchor),
        ])
    }
    
    func configure(image: String, name: String, transmission: String, seats: String, fuel: String) {
        if let url = URL(string: image) {
            carImage.kf.setImage(with: url)
        }
        
        carName.text = name
        carTransmission.text = transmission
        carSeats.text = seats
        carFuel.text = fuel
    }
}

