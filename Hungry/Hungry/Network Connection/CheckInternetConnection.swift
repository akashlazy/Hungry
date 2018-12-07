
import Foundation

class CheckInternet {
    
    class func isConnected() -> Bool {
        
        /*
        Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
        */
        
        NotificationCenter.default.post(name: NSNotification.Name.reachabilityChanged, object: nil)
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        
        let internetReachability = Reachability.forInternetConnection()
        let netStatus: NetworkStatus = internetReachability!.currentReachabilityStatus()
        internetReachability?.startNotifier()
        
        if netStatus == NotReachable {
            return false
        } else {
            return true
        }
    }
}
