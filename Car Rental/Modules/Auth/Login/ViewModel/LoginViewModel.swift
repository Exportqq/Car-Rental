import Foundation

protocol LoginViewModelInputProtocol: AnyObject {
    var loginTitle: String { get }
    var loginTxt: String { get }
}

final class LoginViewModel: LoginViewModelInputProtocol {
    var loginTitle: String = "Welcome !"
    var loginTxt: String = "Enter the information to create\n your account."
}

