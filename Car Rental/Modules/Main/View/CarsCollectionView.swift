import UIKit
import Kingfisher
import Combine

final class CarsCollectionView: UIViewController {

    let viewModel = CarsCollectionViewViewModel()
    private var cancellables = Set<AnyCancellable>()

    var onCarsSelected: ((CarsModel) -> Void)?

    private var allCars: [CarsModel] = []
    private var cars: [CarsModel] = []

    private let carTitle: UILabel = {
        let label = UILabel()
        label.text = "Cars"
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
        cv.clipsToBounds = false

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

        view.addSubview(carTitle)
        view.addSubview(collectionView)

        carTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            carTitle.topAnchor.constraint(equalTo: view.topAnchor),
            carTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carTitle.heightAnchor.constraint(equalToConstant: 28),

            collectionView.topAnchor.constraint(equalTo: carTitle.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func update(with data: [CarsModel]) {
        self.allCars = data
        self.cars = data
        collectionView.reloadData()
    }
    
    func filterCars(by brandName: String?) {

        guard let brandName else {
            cars = allCars
            collectionView.reloadData()
            return
        }

        cars = allCars.filter { car in
            car.brand?.lowercased() == brandName.lowercased()
        }

        collectionView.reloadData()
    }

    private func loadData() {
        guard cars.isEmpty else { return }

        Task {
            do {
                let data = try await viewModel.fetchCars()
                self.update(with: data)
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
                isLoading ? self.showLoader() : self.hideLoader()
            }
            .store(in: &cancellables)
    }
    
    func applyFilters(brand: String?, searchText: String?) {

        cars = allCars.filter { car in

            let matchesBrand: Bool = {
                guard let brand else { return true }

                return car.brand?
                    .lowercased()
                    .contains(brand.lowercased()) ?? false
            }()

            let matchesSearch: Bool = {
                guard let searchText,
                      !searchText.isEmpty else { return true }

                return car.name?
                    .lowercased()
                    .contains(searchText.lowercased()) ?? false
            }()

            return matchesBrand && matchesSearch
        }

        collectionView.reloadData()
    }
}

extension CarsCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CarsCell",
            for: indexPath
        ) as! CarsCell

        let car = cars[indexPath.item]

        let fullUrl = APIConstants.baseURL + (car.car_image ?? "")

        cell.card.configure(
            image: fullUrl,
            name: car.name ?? "",
            transmission: car.transmission ?? "",
            seats: car.seats,
            fuel: car.fuel_type ?? ""
        )

        cell.card.onDetailTap = { [weak self] in
            guard let self else { return }
            self.onCarsSelected?(car)
        }

        return cell
    }
}

extension CarsCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCarsSelected?(cars[indexPath.item])
    }
}

extension CarsCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        CGSize(width: collectionView.frame.width, height: 171)
    }
}
