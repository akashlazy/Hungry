
import Foundation

class ConnRequestManager {
    
    func getRequest(_ methodName: String, classRef: AnyObject!) {
        getRequest(methodName, dict: nil, classRef: classRef)
    }
    
    func getRequest(_ methodName: String, dict: NSMutableDictionary?, classRef: AnyObject!) {
        
        let serverIP = Constant.URL.serverAddress + methodName
        
        ////Call For HTTP Connection
        let httpObj = ConnHttpConnection()
        httpObj.sendServerRequest(serverIP, methodName: methodName, classRef:classRef, dict: dict)
    }
}
