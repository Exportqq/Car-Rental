import UIKit

class MainViewConrtoller: UIViewController {
    
    private lazy var search = CustomSearchBarView(searchDelegate: self)
    
    private var currentSearchText: String = ""
    private var selectedBrand: String?
    
    private let avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.clipsToBounds = true

        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        return view
    }()
    
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [search, avatarView])
        stack.axis = .horizontal
        stack.spacing = 13
        return stack
    }()
    
    private let brandsScreen = BrandsCollectionView()
    
    private let carsScreen = CarsCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupCarsSelection()
        setupBrandSelection()
    }
    
    private func SetupView() {
        view.backgroundColor = .backClr
        
        view.addSubview(headerStack)
        
        addChild(brandsScreen)
        view.addSubview(brandsScreen.view)
        brandsScreen.didMove(toParent: self)
        brandsScreen.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(carsScreen)
        view.addSubview(carsScreen.view)
        carsScreen.didMove(toParent: self)
        carsScreen.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func SetupConstraints() {
        [headerStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            avatarView.heightAnchor.constraint(equalToConstant: 48),
            avatarView.widthAnchor.constraint(equalToConstant: 48),
            
            search.heightAnchor.constraint(equalToConstant: 48),
            
            headerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            brandsScreen.view.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
            brandsScreen.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            brandsScreen.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            brandsScreen.view.heightAnchor.constraint(equalToConstant: 94),
            
            carsScreen.view.topAnchor.constraint(equalTo: brandsScreen.view.bottomAnchor, constant: 32),
            carsScreen.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            carsScreen.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            carsScreen.view.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func applyFilters() {

        carsScreen.applyFilters(
            brand: selectedBrand,
            searchText: currentSearchText
        )
    }
    
    private func setupBrandSelection() {

        brandsScreen.onBrandsSelected = { [weak self] brand in
            guard let self else { return }

            self.selectedBrand = brand?.name
            self.applyFilters()
        }
    }
    
    
    
    private func setupCarsSelection() {
        carsScreen.onCarsSelected = { [weak self] car in
            guard let self else { return }

            let vc = CarDetailViewController()

            let baseUrl = APIConstants.baseURL
            let fullUrl = baseUrl + (car.car_image ?? "")

            let isHourly = vc.carDetailPlans.selectedPlan == "hourly"

            vc.configure(
                name: car.name ?? "",
                raiting: car.rating ?? 0,
                reviews: car.reviews_count ?? "",
                imageUrl: fullUrl,
                power: car.horsepower ?? "",
                max_speed: car.max_speed ?? "",
                acceleration: car.characteristics ?? "",
                location: car.location ?? "",
                price: isHourly ? car.price_per_hour : car.price_per_day,
                type: isHourly ? "/ hour" : "/ day",
                pricePerDay: car.price_per_day,
                pricePerHourly: car.price_per_hour
            )

            vc.carDetailPlans.onPlanSelected = { plan in
                
                let isHourly = plan == "hourly"

                vc.updatePrice(
                    price: isHourly ? car.price_per_hour : car.price_per_day,
                    type: isHourly ? "/ hour" : "/ day"
                )
                
                vc.alertTitle = "Your pick up: \(car.name ?? "")"
                vc.alertText = "Your plan: \(isHourly ? "hourly" : "/ days"), price: \(isHourly ? car.price_per_hour : car.price_per_day)"
            }
            
            NavigationHelper.push(vc, from: self)
        }
    }
    
}

extension MainViewConrtoller: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(
            withTarget: self,
            selector: #selector(reloadSearch(_:)),
            object: searchBar
        )
        
        perform(#selector(reloadSearch(_:)), with: searchBar, afterDelay: 0.5)
    }

    @objc private func reloadSearch(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        currentSearchText = text
        applyFilters()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        currentSearchText = ""
        applyFilters()
    }
}
