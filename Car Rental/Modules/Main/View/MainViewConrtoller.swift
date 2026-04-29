import UIKit

class MainViewConrtoller: UIViewController {
    private let test: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(test)
    }
    
    private func SetupConstraints() {
        [test].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
