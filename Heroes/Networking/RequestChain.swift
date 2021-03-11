//
//  RequestChain.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation
import Alamofire

final class RequestChain {
    typealias CompletionHandler = (_ success: Bool, _ errorResult: ErrorResult?) -> Void
    
    struct ErrorResult {
        let request: DataRequest?
        let error: Error?
    }
    
    private var requests: [DataRequest] = []
    
    init(requests: [DataRequest]) {
        self.requests = requests
    }
    
    func start(_ completionHandler: @escaping CompletionHandler) {
        if let request = requests.first {
            request.response(completionHandler: { (response: AFDataResponse) in
                if let error = response.error {
                    completionHandler(false, ErrorResult(request: request, error: error))
                    return
                }
                self.requests.removeFirst()
                self.start(completionHandler)
            })
            request.resume()
        } else {
            completionHandler(true, nil)
            return
        }
    }
}
