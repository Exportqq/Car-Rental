import Foundation

protocol AuthViewModelInputProtocol: AnyObject {
    var companyName: String { get }
    var welcomeTitle: String { get }
    var welcomeTxt: String { get }
}

final class AuthViewModel: AuthViewModelInputProtocol {
    var companyName: String = "CAR RENTAL"
    var welcomeTitle: String = "Welcome !"
    var welcomeTxt: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et"
}

