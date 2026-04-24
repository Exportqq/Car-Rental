import UIKit

class AuthViewController: UIViewController {
    private let logo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        return img
    }()
    
    private let companyName: UILabel = {
        let label = UILabel()
        label.text = "CAR RENTAL"
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.textColor = .textGrey
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logo, companyName])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 18
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .backClr
        
        view.addSubview(stackView)
    }
    
    private func SetupConstraints() {
        [stackView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 105),
            logo.heightAnchor.constraint(equalToConstant: 70),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
