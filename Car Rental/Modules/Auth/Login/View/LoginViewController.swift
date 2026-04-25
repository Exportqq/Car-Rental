import UIKit

class LoginViewController: UIViewController {
    
    private let backButton = BackButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func SetupView() {
        view.backgroundColor = .backClr
        navigationItem.hidesBackButton = true
        
        view.addSubview(backButton)
    }
    
    private func SetupConstraints() {
        [backButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func setupActions() {
        backButton.configure() { [weak self] in
            self?.pushBack()
        }
    }
    
    @objc private func pushBack() {
        NavigationHelper.pop(from: self)
    }
}
