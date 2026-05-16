import UIKit

class CarDetailSpecsView: UIView {
    private let specPower = SpecsCardView()
    private let specSpeed = SpecsCardView()
    private let specAcceleration = SpecsCardView()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true
        return scroll
    }()
    
    private lazy var specsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [specPower, specSpeed, specAcceleration])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()
    
    let specTitle: UILabel = {
        let label = UILabel()
        label.text = "Specs"
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textColor = .textBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(specTitle)
        addSubview(scrollView)
        scrollView.addSubview(specsStack)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
    }
    
    private func setupConstrains() {
        [specsStack, scrollView, specTitle].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [specPower, specSpeed, specAcceleration].forEach {
            $0.widthAnchor.constraint(equalToConstant: 124).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        NSLayoutConstraint.activate([
            specTitle.topAnchor.constraint(equalTo: self.topAnchor),
            specTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            specTitle.heightAnchor.constraint(equalToConstant: 21),
            
            scrollView.topAnchor.constraint(equalTo: specTitle.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 48),

            specsStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            specsStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            specsStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            specsStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            specsStack.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
    
    func configure(power: String, max_speed: String, acceleration: String) {
        specPower.configure(name: "Power", info: "\(power) hp @")
        specSpeed.configure(name: "Max speed", info: acceleration)
        specAcceleration.configure(name: "Acceleration", info: acceleration)
    }
}

