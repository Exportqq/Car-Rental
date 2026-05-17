import UIKit
import Kingfisher

class CarDetailViewController: UIViewController {
    
    var alertTitle: String?
    var alertText: String?
    
    private let carDetailHeader = CarDetailHeaderView()
    
    private let carDetailSpecs = CarDetailSpecsView()
    
    let carDetailPlans = CarDetailPlanView()
    
    let carDetailLocation = CarDetailLocationView()
    
    private lazy var carDetailStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carDetailSpecs, carDetailPlans, carDetailLocation])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func SetupView() {
        view.addSubview(carDetailHeader)
        view.addSubview(carDetailStack)
    }
    
    private func SetupConstraints() {
        [carDetailHeader, carDetailStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            carDetailHeader.topAnchor.constraint(equalTo: view.topAnchor),
            carDetailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carDetailHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carDetailHeader.heightAnchor.constraint(equalToConstant: 410),
            
            carDetailSpecs.heightAnchor.constraint(equalToConstant: 85),
            carDetailPlans.heightAnchor.constraint(equalToConstant: 118),
            carDetailLocation.heightAnchor.constraint(equalToConstant: 134),
            
            carDetailStack.topAnchor.constraint(equalTo: carDetailHeader.bottomAnchor, constant: 24),
            carDetailStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            carDetailStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
        ])
    }

    func configure(name: String, raiting: Double, reviews: String, imageUrl: String, power: String, max_speed: String, acceleration: String, location: String, price: Int, type: String, pricePerDay: Int, pricePerHourly: Int) {
        
        if let url = URL(string: imageUrl) {
            carDetailHeader.carImage.kf.setImage(with: url)
        }
        
        carDetailHeader.configure(
            name: name,
            raiting: raiting,
            reviews: reviews,
            imageUrl: imageUrl,
        )
        
        carDetailSpecs.configure(
            power: power,
            max_speed: max_speed,
            acceleration: acceleration
        )
        
        carDetailPlans.configure(
            priceHourly: pricePerHourly,
            priceDaily: pricePerDay
        )
        
        carDetailLocation.configure(
            location: location,
            price: price,
            type: type
        )
    }
    
    func updatePrice(price: Int, type: String) {
        carDetailLocation.updatePrice(
            price: price,
            type: type
        )
    }
    
    private func setupActions() {
        carDetailHeader.onBackTapped = { [weak self] in
            guard let self else { return }
            NavigationHelper.pop(from: self)
        }
        
        carDetailLocation.onPickUpTapped = { [weak self] in
            guard let self else {return}
                self.showAlert()
            }
    }
    
    private func showAlert() {
        
        
        let alert = UIAlertController(
            title: alertTitle,
            message: alertText,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
    
}
