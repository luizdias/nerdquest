//
//  API.swift
//  NerdQuest App
//
//  Created by Luiz Dias on 06/20/16.
//  Copyright © 2015 Luiz Dias. All rights reserved.
//

import Foundation
//import Alamofire
import SwiftyJSON

class API {
    
    private let hostname = "http://www.mocky.io/v2"
//    private let hostname = "https://resonant-time-128918.firebaseio.com"
    private let hostdummy = "http://localhost:3000"

    //TODO: Networking disabled for this MVP version. Re-enable it here:
//    let defaultManager: Alamofire.SessionManager = {
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "localhost": .disableEvaluation
//        ]
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//        configuration.timeoutIntervalForResource = 20 //seconds
//        
//        return Alamofire.SessionManager(
//            configuration: configuration,
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//    }()
    
    // Setting up an API Class with a GET method that accepts a delegate of type APIProtocol
    //TODO: Networking disabled for this MVP version. Re-enable it here:
//    func get(path: String, parameters: [String: AnyObject]? = nil, delegate: APIProtocol? = nil){
//        let url = "\(self.hostname)\(path)"
//        NSLog("Preparing for GET request to: \(url)")
//        
//        Alamofire.request(url, method: .get, parameters: parameters)
//            .validate()
//            //TODO: Use NSURLCache to handle network caching in the future
////            .response {(request, res, data, error) in
////                let cachedURLResponse = NSCachedURLResponse(response: res!, data: (data! as NSData), userInfo: nil, storagePolicy: .Allowed)
////                NSURLCache.sharedURLCache().storeCachedResponse(cachedURLResponse, forRequest: request!)}
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    print("GET Validation Successful")
//                    let json = JSON(response.result.value!)
//                    print("GET Result: \(json)")
//                    // Call delegate if it was passed into the call
//                    if (delegate != nil) {
//                        delegate!.didReceiveResult(results: json)
//                    }
//                case .failure(let error):
//                    print("GET Error: \(error)")
//                }
//        }
//    }
    
    func getLocalFrom(filename: String, delegate: APIProtocol? = nil){

        let path = Bundle.main.path(forResource: filename, ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        let json = JSON(data: jsonData! as Data)
        print("GET Result: \(json)")
        if (delegate != nil) {
            delegate!.didReceiveResult(results: json)
        }
    }
    
    // Setting up an API Class with a POST method that accepts a elegate of type APIProtocol
    //TODO: Networking disabled for this MVP version. Re-enable it here:
//    func post(path: String, parameters: [String: AnyObject]? = nil, delegate: APIProtocol? = nil){
//        let url = "\(self.hostname)\(path)"
//        NSLog("Preparing for POST request to: \(url)")
//       
//        Alamofire.request(url, method: .post ,parameters: parameters)
//            .validate() 
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    print("Validation Successful")
//                    let json = JSON(response.result.value!)
//                    //                   NSLog("POST Result: \(json)")
//                    
//                    if (json != nil && delegate != nil && json.count != 0){
//                        delegate!.didReceiveResult(results: json)
//                    } else {
//                        delegate!.didErrorHappened(error: NSError(domain: "nerdquestapp.com", code: 1011, userInfo: ["message" : "Não há nada para exibir."]))
//                    }
//                case .failure(let error):
//                    print("POST Error \(error)")
//                    if (delegate != nil){
//                        delegate!.didErrorHappened(error: error as NSError)
//                    }
//                }
//                
//        }
//        
//    }
    
    
    // Setting up an API Class with a GET method that accepts a elegate of type APIProtocol
    //TODO: Networking disabled for this MVP version. Re-enable it here:
//    func getLocal(path: String, parameters: [String: AnyObject]? = nil, delegate: APIProtocol? = nil){
//        let url = "\(self.hostdummy)\(path)"
//        NSLog("Preparing for GET request to: \(url)")
//        
//        defaultManager.request(url, method: .get, parameters: parameters)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    print("GET Validation Successful")
//                    let json = JSON(response.result.value!)
//                    print("GET Result: \(json)")
//                    // Call delegate if it was passed into the call
//                    if (delegate != nil) {
//                        delegate!.didReceiveResult(results: json)
//                    }
//                case .failure(let error):
//                    print("GET Error: \(error)")
//                }
//                
//        }
//    }
    
    
}
// TODO: Image request is not working properly in Swift 3.0 yet.
// Remember that this came originally from Ray Wenderlich's Alamofie Tutorial
//extension Alamofire.Request {
//    
//    public static func imageResponseSerializer() -> ResponseSerializer<UIImage, NSError> {
//        return ResponseSerializer { request, response, data, error in
//            
//            guard let validData = data else {
//                let failureReason = "Data could not be serialized. Input data was nil."
//                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
//                return .Failure(error)
//            }
//            
//            if let image = UIImage(data: validData) {
//                return .Success(image)
//            }
//            else {
//                return .Failure(Error.errorWithCode(.DataSerializationFailed, failureReason: "Unable to create image."))
//            }
//            
//        }
//    }
//    
//    func responseImage(completionHandler: Response<UIImage, NSError> -> Void) -> Self {
//        return response(responseSerializer: Request.imageResponseSerializer(), completionHandler: completionHandler)
//    }
//}
