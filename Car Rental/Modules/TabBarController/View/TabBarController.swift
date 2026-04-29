import UIKit

final class TabBarController: UITabBarController {

    private let customTabBar = CustomTabBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        tabBar.isHidden = true
        setupTabs()
        setupCustomTabBar()
    }

    private func setupTabs() {
        let main = MainViewConrtoller()
        let map = MapViewConrtoller()
        let profile = ProfileViewController()

        viewControllers = [
            main,
            map,
            profile,
        ]
    }

    private func setupCustomTabBar() {
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            customTabBar.heightAnchor.constraint(equalToConstant: 32)
        ])

        customTabBar.onSelect = { [weak self] index in
            self?.selectedIndex = index
        }
    }

}

