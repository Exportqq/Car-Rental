import UIKit

final class LoadingView: UIView {

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        layer.cornerRadius = 10

        activityIndicator.color = .brandClr
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        isHidden = true
    }

    func start() {
        isHidden = false
        activityIndicator.startAnimating()
    }

    func stop() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
