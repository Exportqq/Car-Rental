import UIKit
import Kingfisher

class CarDetailViewController: UIViewController {
    
    private let carDetailHeader = CarDetailHeaderView()
    
    private let carDetailSpecs = CarDetailSpecsView()
    
    private let carDetailPlans = CarDetailPlanView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
        
    }
    
    private func SetupView() {
        view.addSubview(carDetailHeader)
        view.addSubview(carDetailSpecs)
        view.addSubview(carDetailPlans)
    }
    
    private func SetupConstraints() {
        [carDetailHeader, carDetailSpecs, carDetailPlans].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            carDetailHeader.topAnchor.constraint(equalTo: view.topAnchor),
            carDetailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carDetailHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carDetailHeader.heightAnchor.constraint(equalToConstant: 410),
            
            carDetailSpecs.topAnchor.constraint(equalTo: carDetailHeader.bottomAnchor, constant: 26),
            carDetailSpecs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            carDetailSpecs.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carDetailSpecs.heightAnchor.constraint(equalToConstant: 85),
            
            carDetailPlans.topAnchor.constraint(equalTo: carDetailSpecs.bottomAnchor, constant: 26),
            carDetailPlans.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            carDetailPlans.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carDetailPlans.heightAnchor.constraint(equalToConstant: 118),
        ])
    }

    func configure(name: String, raiting: Double, reviews: String, imageUrl: String, power: String, max_speed: String, acceleration: String) {
        
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
        
        carDetailPlans.configure(priceHourly: 100, priceDaily: 500)
    }
    
    private func setupActions() {
        carDetailHeader.onBackTapped = { [weak self] in
            guard let self else { return }
            NavigationHelper.pop(from: self)
        }
    }
}
