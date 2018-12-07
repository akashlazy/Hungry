
import Foundation
import SwiftyJSON
import Async

class ConnHttpConnection {
    var classRefs: AnyObject! = nil
    
    fileprivate var mMethod: String?
    fileprivate var mURL: String?

    fileprivate var mResponseCode: Int = 0;
    fileprivate var appPrefs = MySharedPreference()
    
    
    func sendServerRequest(_ url: String, methodName: String, classRef: AnyObject!, dict: NSMutableDictionary?) {
        var json: JSON? = nil
        
        if dict != nil {
            json = JSON(dict!)
        }
        classRefs = classRef
        
        
        if methodName == Constant.MethodCommon.methodCategories {
            json = ConnJsonCreator().putDefaultJSON()
        } else if methodName == Constant.MethodCommon.methodCollections {
            json = ConnJsonCreator().putCollecionsJSON()
        } else if methodName == Constant.MethodCommon.methodCuisines {
            json = ConnJsonCreator().putCollecionsJSON()
        } else if methodName == Constant.MethodCommon.methodGeocode {
            json = ConnJsonCreator().putCollecionsJSON()
        } else if methodName == Constant.Restaurant.methodReviews {
            json = ConnJsonCreator().putCollecionsJSON()
        } else if methodName == Constant.Location.methodLocations {
            json = ConnJsonCreator().putCollecionsJSON()
        } else if methodName == Constant.Restaurant.methodRestaurant {
            json = ConnJsonCreator().putCollecionsJSON()
        }
        
        
        //execute Http Connection
        let customObj = NetworkConnection()
        customObj.sendGetRequestToRest(url, json: json!, methodName: methodName, classRef: self)
    }
    
    func getServerResponce(json: JSON, methodName: String) {
        let mySharedObj = MySharedPreference()
        if !json.isNull {
            if methodName == Constant.MethodCommon.methodCategories {

                ConnJsonCreator().storeCategories(json)
             
            } else if methodName == Constant.MethodCommon.methodCollections {
                ConnJsonCreator().storeCollecions(json)
            } else if methodName == Constant.MethodCommon.methodCuisines {
                ConnJsonCreator().storeCuisines(json)
            } else if methodName == Constant.Location.methodLocations {
                ConnJsonCreator().storeCityLocation(json)
            } else if methodName == Constant.MethodCommon.methodGeocode {
                ConnJsonCreator().storeLocationGeocode(json)
                
                if classRefs.isKind(of: MainViewController.self) {
                    (self.classRefs as! MainViewController).refreshData()
                }
            } else if methodName == Constant.Restaurant.methodRestaurant {
                ConnJsonCreator().storeLocationGeocode(json)
                
                if classRefs.isKind(of: DetailScreenVC.self) {
                    (self.classRefs as! DetailScreenVC).refreshData()
                }
            }
            
        } else {
            if methodName == Constant.MethodCommon.methodGeocode {

                if classRefs.isKind(of: MainViewController.self) {
                    (self.classRefs as! MainViewController).refreshData()
                }
            }
            
            mErrDialogue("The Internet connection appears to be offline")
        }
    }
     
    // Alert Box to Show error Messages
    fileprivate func mErrDialogue(_ message: String) {
        SweetAlert().showAlert("fail".localized, subTitle: message, style: .error)
    }
}

extension JSON {
    public var isNull: Bool {
        get {
            return self.type == .null
        }
    }
}
