
import Foundation

//MARK:- OTP Request Model
class OTPRequestModel : Encodable{
    var email: String?
    var phone: String?
    var countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case phone = "mobile_no"
        case countryCode = "country_code"
    }
}

//MARK:- OTP Response Model
class OTPResponseModel: Codable {
    var status: Bool?
    var otp: Int?
    var message: String?
    
    init(status: Bool?, otp: Int?, message: String?) {
        self.status = status
        self.otp = otp
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        otp = try? values?.decodeIfPresent(Int.self, forKey: .otp)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
    }
}

//MARK:- Register Request Model
class RegisterRequestModel: Encodable{
    var firstName : String?
    var lastName : String?
    var email : String?
    var password : String?
    var phone : String?
    var birthDate : String?
    var gender : String?
    var address : String?
    var countryCode : String?
    var countryId : String?
    var deviceType : String? = SingletonClass.sharedInstance.DeviceType
    var deviceToken : String? = SingletonClass.sharedInstance.DeviceToken
    var latitude : String? = SingletonClass.sharedInstance.locationString().latitude
    var longitude : String? = SingletonClass.sharedInstance.locationString().longitude
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
        case phone = "mobile_no"
        case birthDate = "dob"
        case gender = "gender"
        case latitude = "lat"
        case longitude = "lng"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case address = "address"
        case countryCode = "country_code"
        case countryId = "country_id"
    }
}


//MARK:- Social Login Request Model
class SocialLoginRequestModel: Encodable{
    var socialId : String?
    var socialType : String?
    var firstName : String?
    var lastName : String?
    var deviceType : String? = SingletonClass.sharedInstance.DeviceType
    var deviceToken : String? = SingletonClass.sharedInstance.DeviceToken
    var latitude : String? = SingletonClass.sharedInstance.locationString().latitude
    var longitude : String? = SingletonClass.sharedInstance.locationString().longitude
    
    enum CodingKeys: String, CodingKey {
        case socialId = "social_id"
        case socialType = "social_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case latitude = "lat"
        case longitude = "lng"
    }
}

