import UIKit

class CustomSearchBarView: UIView {

    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.backgroundImage = UIImage()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    init(searchDelegate: UISearchBarDelegate) {
        super.init(frame: .zero)

        searchBar.delegate = searchDelegate
        setupView()
        setupConstraints()
        customize()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(searchBar)
    
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func customize() {
        guard let textField = searchBar.searchTextField as UITextField? else { return }

        textField.backgroundColor = .white
        textField.borderStyle = .none
        textField.clearButtonMode = .never
        textField.textColor = .textGrey
        textField.layer.cornerRadius = 24


        let icon = UIImage(named: "search")
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            
        )
        let iconView = UIImageView(image: icon)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)

        textField.leftView = iconView
        textField.leftViewMode = .always
    }
}
