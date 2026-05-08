import UIKit
import Kingfisher
import Combine

final class CarsCollectionView: UIViewController {
    
    let viewModel = CarsCollectionViewViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var onCarsSelected: ((CarsModel) -> Void)?
    
    private var cars: [CarsModel] = []
    
    private let carTitle: UILabel = {
        let label = UILabel()
        label.text = "cars"
        label.textColor = .textBlack
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 9
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cv.register(CarsCell.self, forCellWithReuseIdentifier: "CarsCell")
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        bindViewModel()
        
        view.addSubview(collectionView)
        view.addSubview(carTitle)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carTitle.topAnchor.constraint(equalTo: view.topAnchor),
            carTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carTitle.heightAnchor.constraint(equalToConstant: 28),
            
            collectionView.topAnchor.constraint(equalTo: carTitle.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func update(with data: [CarsModel]) {
        self.cars = data
        collectionView.reloadData()
    }
    
    private func loadData() {
        guard cars.isEmpty else { return }

        Task {
            do {
                let cars = try await viewModel.fetchCars()
                self.update(with: cars)
            } catch {
                print(error)
            }
        }
    }
    
    private func bindViewModel() {
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                
                if isLoading {
                    self.showLoader()
                } else {
                    self.hideLoader()
                }
            }
            .store(in: &cancellables)
    }
}

extension CarsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CarsCell",
            for: indexPath
        ) as! CarsCell
        
        let cars = cars[indexPath.item]
        
        let fullUrl = APIConstants.baseURL + (cars.car_image ?? "")
        
        cell.card.configure(
            image: fullUrl,
            name: cars.name ?? "",
            transmission: cars.transmission ?? "",
            seats: cars.seats,
            fuel: cars.fuel_type ?? ""
        )
        
        return cell
    }
}

extension CarsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 87, height: 94)
    }
}

extension CarsCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCar = cars[indexPath.item]
        onCarsSelected?(selectedCar)
    }
}
