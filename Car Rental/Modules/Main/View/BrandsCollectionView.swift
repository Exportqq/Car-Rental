import UIKit
import Kingfisher

final class BrandsCollectionView: UIViewController {
    
    let viewModel = BrandsCollectionViewViewModel()
    
    var onBrandsSelected: ((BrandsModel) -> Void)?
    
    private var brands: [BrandsModel] = []
    
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
        
        cv.register(BrandsCell.self, forCellWithReuseIdentifier: "BrandsCell")
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func update(with data: [BrandsModel]) {
        self.brands = data
        collectionView.reloadData()
    }
    
    private func loadData() {
        Task {
            do {
                let brands = try await viewModel.fetchBrands()
                self.update(with: brands)
            } catch {
                print(error)
            }
        }
    }
}

extension BrandsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BrandsCell",
            for: indexPath
        ) as! BrandsCell
        
        let brands = brands[indexPath.item]
        
        let fullUrl = APIConstants.baseURL + (brands.image ?? "")
        
        cell.card.configure(
            image: fullUrl,
            brand: brands.name ?? "",
        )
        
        return cell
    }
}

extension BrandsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 87, height: 94)
    }
}

extension BrandsCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBrand = brands[indexPath.item]
        onBrandsSelected?(selectedBrand)
    }
}
