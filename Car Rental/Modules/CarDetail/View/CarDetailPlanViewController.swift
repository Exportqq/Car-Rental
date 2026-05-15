import UIKit

class Catalog: UIViewController {
    private let cardBackground: UIView = {
        
    }
    
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
