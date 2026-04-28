import UIKit
import Combine

final class RegisterViewController: UIViewController {
    
    private let backButton = BackButtonView()
    private let viewModel = RegisterViewModel()
    
    private let nameInput = CustomTextField()
    private let passwordInput = CustomTextField()
    
    private let signUpButton = CustomButtonUIButton()
    
    private let registerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 36)
        label.textColor = .textBlack
        return label
    }()
    
    private let registerTxt: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = .textGrey
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [registerTitle, registerTxt])
        stack.axis = .vertical
        return stack
    }()
    
    private let inputViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var textFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameInput, passwordInput, signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .backClr
        navigationItem.hidesBackButton = true
        
        view.addSubview(backButton)
        view.addSubview(textStack)
        view.addSubview(inputViewContainer)
        view.addSubview(textFieldsStack)
        
        registerTitle.text = viewModel.registerTitle
        registerTxt.text = viewModel.registerTxt
    }
    
    private func setupConstraints() {
        [backButton, textStack, inputViewContainer, textFieldsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            
            inputViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            inputViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputViewContainer.heightAnchor.constraint(equalToConstant: 385),
            
            textStack.bottomAnchor.constraint(equalTo: inputViewContainer.topAnchor, constant: -37),
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            nameInput.heightAnchor.constraint(equalToConstant: 56),
            passwordInput.heightAnchor.constraint(equalToConstant: 56),
            
            textFieldsStack.topAnchor.constraint(equalTo: inputViewContainer.topAnchor, constant: 62),
            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupActions() {
        backButton.configure { [weak self] in
            self?.pushBack()
        }
        
        signUpButton.configure(title: "Sign up", typeFill: true) { [weak self] in
            self?.signUp()
        }
        
        nameInput.configure(placeholder: "Full name")
        passwordInput.configure(placeholder: "Password")
    }
    
    private func bindViewModel() {
        nameInput.textPublisher
            .assign(to: \.username, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                
                if isLoading {
                    self.showLoader()
                    self.signUpButton.isEnabled = false
                } else {
                    self.hideLoader()
                    self.signUpButton.isEnabled = true
                }
            }
            .store(in: &cancellables)
        
        passwordInput.textPublisher
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$isFormValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.signUpButton.isEnabled = isValid
                self?.signUpButton.alpha = isValid ? 1.0 : 0.5
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.signUpButton.isEnabled = !isLoading
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showError(error)
            }
            .store(in: &cancellables)
        
        viewModel.$isSuccess
            .filter { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                NavigationHelper.push(ProfileViewController(), from: self)
            }
            .store(in: &cancellables)
    }
    
    @objc private func pushBack() {
        NavigationHelper.pop(from: self)
    }
    
    @objc private func signUp() {
        viewModel.register()
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
