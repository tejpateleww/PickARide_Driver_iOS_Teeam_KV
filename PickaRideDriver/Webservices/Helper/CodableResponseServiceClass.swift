//
//  CodableResponseServiceClass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation


class CodableService {
    class func getResponseFromSession<C:Codable>(request: URLRequest, codableObj: C.Type, completion: @escaping  (_ status: Bool,_ apiMessage: String,_ modelObj: C?,_ dataDic: Any) -> ()){
        var responseDic = [String:Any]()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let ERR = error{
                        completion(false, UrlConstant.SomethingWentWrong, nil, ERR.localizedDescription)
                  
                }else{
                    if let httpResponse = response as? HTTPURLResponse{
                        print("Status code of the request:=>",httpResponse.statusCode)
                        var statusCode = httpResponse.statusCode == 200
                        if httpResponse.statusCode == 200{
                            if  let responseData = data {
                                
                                responseDic = getResponseDicFromData(responseData: responseData)
                                let alertMessage = Utilities.getMessageFromApiResponse(param: responseDic)
                                
                                if let APIStatus = responseDic[UrlConstant.Status] as? Bool {
                                    statusCode = APIStatus
                                }
                                if let obj = getCodableObjectFromData(jsonData: responseData, codableObj: codableObj){
                                    completion(statusCode, alertMessage, obj, responseDic)
                                }else{
                                    completion(statusCode, alertMessage, nil, responseDic)
                                }
                            }else{
                                completion(statusCode, UrlConstant.SomethingWentWrong, nil, ErrorResponseDic)
                            }
                        }else if httpResponse.statusCode == 403{
                            //Do Force Logout
                            completion(statusCode, UrlConstant.SomethingWentWrong, nil, ErrorResponseDic)
                        }else{
                            completion(statusCode, UrlConstant.SomethingWentWrong, nil, ErrorResponseDic)
                        }
                    }
                }
            }
        }.resume()
    }
    
    class func getCodableObjectFromData<C:Codable>(jsonData: Data, codableObj: C.Type) -> C?{
         let obj = try? JSONDecoder().decode(codableObj, from: jsonData)
        return obj
    }
    
    class func getResponseDicFromData(responseData: Data) -> [String:Any]{
        var responseDic = [String:Any]()
        let jso = try? JSONSerialization.jsonObject(with: responseData)
        
        
        if let jsonObj = jso, let mainDic = jsonObj as? [String: Any]{
            responseDic = mainDic
        }else{
            responseDic = ErrorResponseDic
        }
        
        print("The webservice call response \n \(responseDic)")
        
        return responseDic
    }
}
