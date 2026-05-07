import UIKit

class BackButtonView: UIView {
        
    private lazy var сustomBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let buttonImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    private var nextPageAction: (() -> Void)?

    @objc private func getNextPage() {
        nextPageAction?()
    }

    func configure(nextPage: @escaping () -> Void) {
        nextPageAction = nextPage
        сustomBtn.addTarget(self, action: #selector(getNextPage), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(сustomBtn)
        addSubview(buttonImg)
    }
    
    
    private func setupConstrains() {
        [сustomBtn, buttonImg].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            сustomBtn.topAnchor.constraint(equalTo: self.topAnchor),
            сustomBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            сustomBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            сustomBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            сustomBtn.heightAnchor.constraint(equalToConstant: 48),
            
            buttonImg.centerXAnchor.constraint(equalTo: сustomBtn.centerXAnchor, constant: -1),
            buttonImg.centerYAnchor.constraint(equalTo: сustomBtn.centerYAnchor)
        ])
    }
}
