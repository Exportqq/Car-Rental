import UIKit

enum NavigationHelper {

    static func push(
        _ viewController: UIViewController,
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }

    static func present(
        _ viewController: UIViewController,
        from current: UIViewController,
        style: UIModalPresentationStyle = .fullScreen,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        animated: Bool = true
    ) {
        viewController.modalPresentationStyle = style
        viewController.modalTransitionStyle = transitionStyle
        current.present(viewController, animated: animated)
    }

    static func dismiss(
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.dismiss(animated: animated)
    }

    static func pop(
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.navigationController?.popViewController(animated: animated)
    }

    static func popToRoot(
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.navigationController?.popToRootViewController(animated: animated)
    }
}
