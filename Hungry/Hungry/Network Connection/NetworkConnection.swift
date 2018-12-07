

import Foundation
import Alamofire
import SwiftyJSON
import Async

class NetworkConnection {
    func sendGetRequestToRest(_ urlEndString: String, json: JSON, methodName: String, classRef: AnyObject!) {
        
        let headers: HTTPHeaders = [
            "user-key": Constant.API.zomatokey,
            "Accept": "application/json"
        ]
        
        let queue = DispatchQueue.global(qos: .utility)
        
        Alamofire.request(urlEndString, method: .get, parameters: json.dictionaryObject!, encoding: URLEncoding.default, headers: headers).responseJSON(queue: queue, options: JSONSerialization.ReadingOptions.mutableContainers, completionHandler: { responce in
            
            print(responce)
            
            Async.main({
                if responce.result.isSuccess {
                    let respJson = JSON(responce.value!)
                    if classRef.isKind(of: ConnHttpConnection.self) {
                        (classRef as! ConnHttpConnection).getServerResponce(json: respJson, methodName: methodName)
                    }
                } else {
                    if classRef.isKind(of: ConnHttpConnection.self) {
                        (classRef as! ConnHttpConnection).getServerResponce(json: nil, methodName: methodName)
                    }
                }
            })
        })
    }

}
