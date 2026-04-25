import UIKit

class LoginViewController: UIViewController {
    
    private let backButton = BackButtonView()
    private let viewModel = LoginViewModel()
    
    private let nameInput = CustomTextField()
    private let passwordInput = CustomTextField()
    
    private let signInButton = CustomButtonView()
    
    private let loginTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 36)
        label.textColor = .textBlack
        return label
    }()
    
    private let loginTxt: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = .textGrey
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginTitle, loginTxt])
        stack.axis = .vertical
        return stack
    }()
    
    private let inpfutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var textFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameInput, passwordInput, signInButton])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
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
        view.addSubview(textStack)
        view.addSubview(inpfutView)
        view.addSubview(textFieldsStack)
        
        loginTitle.text = viewModel.loginTitle
        loginTxt.text = viewModel.loginTxt
    }
    
    private func SetupConstraints() {
        [backButton, textStack, inpfutView, textFieldsStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            
            inpfutView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            inpfutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inpfutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inpfutView.heightAnchor.constraint(equalToConstant: 385),
            
            textStack.bottomAnchor.constraint(equalTo: inpfutView.topAnchor, constant: -37),
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            nameInput.heightAnchor.constraint(equalToConstant: 56),
            passwordInput.heightAnchor.constraint(equalToConstant: 56),
            
            textFieldsStack.topAnchor.constraint(equalTo: inpfutView.topAnchor, constant: 62),
            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupActions() {
        backButton.configure() { [weak self] in
            self?.pushBack()
        }
        
        signInButton.configure(title: "Sign in", typeFill: true) { [weak self] in
            self?.signIn()
        }
        
        nameInput.configure(placeholder: "Full name")
        passwordInput.configure(placeholder: "Password")
    }
    
    @objc private func pushBack() {
        NavigationHelper.pop(from: self)
    }
    
    @objc private func signIn() {
        NavigationHelper.pop(from: self)
    }
}
