import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()

    private let viewModel = ProfileViewModel()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandClr
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let logoutButton = CustomButtonUIButton()
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true

        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        bindViewModel()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProfile()
    }
    
    private func SetupView() {
        view.backgroundColor = .backClr
        
        view.addSubview(profileView)
        view.addSubview(username)
        view.addSubview(logoutButton)
        
    }
    
    private func SetupConstraints() {
        [profileView, username, logoutButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 240),
            
            username.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -35),
            username.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 16),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func bindViewModel() {
        viewModel.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.username.text = user?.username
            }
            .store(in: &cancellables)
        
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
    
    private func loadProfile() {
        guard viewModel.user == nil else { return }
        
        Task {
            do {
                try await viewModel.fetchProfile()
            } catch {
                print("ERROR:", error)
            }
        }
    }
    
    private func setupActions() {
        logoutButton.configure(title: "Logout", typeFill: true) { [weak self] in
            self?.logoutUser()
        }
    }
    
    @objc private func logoutUser() {
        SessionManager.shared.logout()
        if SessionManager.shared.isAuthorized {
            print("ERROR")
        } else {
            NavigationHelper.push(AuthViewController(), from: self)
        }
    }
}
