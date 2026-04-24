import UIKit

class AuthViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private let logo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        return img
    }()
    
    private let companyName: UILabel = {
        let label = UILabel()
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
    
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let welcomeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 36)
        label.textColor = .textBlack
        return label
    }()
    
    private let welcomeTxt: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = .textGrey
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var welcomeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeTitle, welcomeTxt])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private let signInButton = CustomButtonView()
    private let signUpButton = CustomButtonView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        SetupActions()
    }
    
    private func SetupView() {
        view.backgroundColor = .backClr
        
        view.addSubview(stackView)
        view.addSubview(buttonView)
        view.addSubview(welcomeStack)
        view.addSubview(buttonStack)
        
        companyName.text = viewModel.companyName
        welcomeTitle.text = viewModel.welcomeTitle
        welcomeTxt.text = viewModel.welcomeTxt
        
    }
    
    private func SetupConstraints() {
        [stackView, buttonView, welcomeStack, buttonStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 105),
            logo.heightAnchor.constraint(equalToConstant: 70),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 364),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            welcomeStack.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 42),
            welcomeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            welcomeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            buttonStack.topAnchor.constraint(equalTo: welcomeStack.bottomAnchor, constant: 45),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func SetupActions() {
        signInButton.configure(title: "Sign In", typeFill: true) { [weak self] in
            self?.pushLogin()
        }
        
        signUpButton.configure(title: "Sign Up", typeFill: true) { [weak self] in
            self?.pushRegister()
        }
    }
    
    @objc private func pushLogin() {
        NavigationHelper.push(LoginViewController(), from: self)
    }
    
    @objc private func pushRegister() {
        NavigationHelper.push(RegisterViewController(), from: self)
    }
}
