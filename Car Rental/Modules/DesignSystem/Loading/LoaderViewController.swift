import UIKit
import ObjectiveC

private var loaderKey: UInt8 = 0

extension UIViewController {

    private var loadingView: LoadingView {
        if let view = objc_getAssociatedObject(self, &loaderKey) as? LoadingView {
            return view
        } else {
            let view = LoadingView(frame: self.view.bounds)
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)

            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.view.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])

            objc_setAssociatedObject(self, &loaderKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
    }

    func showLoader(text: String? = nil) {
        loadingView.start()
    }

    func hideLoader() {
        loadingView.stop()
    }
}
