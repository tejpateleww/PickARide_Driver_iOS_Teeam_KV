

import Foundation

//MARK:- Forgot Password Request Model
class ForgotPasswordReqModel: Encodable{
    var email : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

//MARK:- Change Password Request Model
class ChangePasswordReqModel: Encodable{
    var oldPassword : String?
    var newPassword : String?
    var customerId : String? = SingletonClass.sharedInstance.UserId
    
    enum CodingKeys: String, CodingKey {
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case customerId = "customer_id"
    }
}

//MARK:- Password Response Model
class PasswordResponseModel: Codable {
    let status: Bool?
    let message: String?

    init(status: Bool?, message: String?) {
        self.status = status
        self.message = message
    }
}
