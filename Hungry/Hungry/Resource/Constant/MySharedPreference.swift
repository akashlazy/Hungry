
import UIKit

class MySharedPreference: NSObject {
    var objCommon = UserDefaults()

    override init() {
        super.init()
        
        objCommon = UserDefaults.standard
    }
    
    // Set Database Created
    func getISDBOperationCreated() -> Bool {
        return objCommon.bool(forKey: "ISDBOperationCreated")
    }
    func setISDBOperationCreated(_ text: Bool) {
        objCommon.set(text, forKey: "ISDBOperationCreated")
        objCommon.synchronize()
    }
    
    //Temp Latitude
    func getTempLatitude() -> Double {
        return objCommon.double(forKey: "TempLatitude")
    }
    func setTempLatitude(_ GcmID: Double) {
        objCommon.set(GcmID, forKey: "TempLatitude")
        objCommon.synchronize()
    }
    //Temp Longitude
    func getTempLongitude() -> Double {
        return objCommon.double(forKey: "TempLongitude")
    }
    func setTempLongitude(_ GcmID: Double) {
        objCommon.set(GcmID, forKey: "TempLongitude")
        objCommon.synchronize()
    }
    
    // Latitude
    func getLatitude() -> Double {
        return objCommon.double(forKey: "Latitude")
    }
    func setLatitude(_ GcmID: Double) {
        objCommon.set(GcmID, forKey: "Latitude")
        objCommon.synchronize()
    }
    // Longitude
    func getLongitude() -> Double {
        return objCommon.double(forKey: "Longitude")
    }
    func setLongitude(_ GcmID: Double) {
        objCommon.set(GcmID, forKey: "Longitude")
        objCommon.synchronize()
    }
    
    // Set GPS Permission
    func getIsGPSPermission() -> Bool {
        return objCommon.bool(forKey: "IsGPSPermission")
    }
    func setIsGPSPermission(_ text: Bool) {
        objCommon.set(text, forKey: "IsGPSPermission")
        objCommon.synchronize()
    }
    
    //City Name of user
    func getCityName() -> String! {
        if objCommon.string(forKey: "CityName") == nil {
            return ""
        } else {
            return objCommon.string(forKey: "CityName")
        }
    }
    func setCityName(_ text: String!) {
        objCommon.set(text, forKey: "CityName")
        objCommon.synchronize()
    }
    
    //User HTTP Response code
    func getHttpResponseCode() -> Int! {
        return objCommon.integer(forKey: "HttpResponseCode")
    }
    func setHttpResponseCode(_ text: Int!) {
        objCommon.set(text, forKey: "HttpResponseCode")
        objCommon.synchronize()
    }
    //User HTTP Response Message
    func getHttpResponseMessage() -> String! {
        if objCommon.string(forKey: "HttpResponseMessage") == nil {
            return ""
        } else {
            return objCommon.string(forKey: "HttpResponseMessage")
        }
    }
    func setHttpResponseMessage(_ text: String!) {
        objCommon.set(text, forKey: "HttpResponseMessage")
        objCommon.synchronize()
    }
    
    func getRestaurantID() -> String! {
        if objCommon.string(forKey: "RestaurantID") == nil {
            return ""
        } else {
            return objCommon.string(forKey: "RestaurantID")
        }
    }
    func setRestaurantID(_ text: String!) {
        objCommon.set(text, forKey: "RestaurantID")
        objCommon.synchronize()
    }
}
