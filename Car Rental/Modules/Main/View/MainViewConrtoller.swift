import UIKit

class MainViewConrtoller: UIViewController {
    
    private lazy var search = CustomSearchBarView(searchDelegate: self)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .backClr
        
        view.addSubview(headerStack)
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
        ])
    }
}

extension MainViewConrtoller: UISearchBarDelegate {
    
}
