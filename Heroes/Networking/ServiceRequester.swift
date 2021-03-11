//
//  ServiceRequester.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation
import Alamofire

final class ServiceRequester {
    func request<T: Decodable>(decoder: JSONDecoder = JSONDecoder(),
                               router: URLRequestConvertible,
                               completion: @escaping(Result<T, NetworkError>) -> Void) -> DataRequest {
        let request = AF.request(router).responseJSON { result in
            guard let data = result.data else {
                return completion(.failure(.noData))
            }
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                return completion(.success(responseObject))
            } catch {
                do {
                    let responseError = try decoder.decode(ResponseError.self, from: data)
                    return completion(.failure(.serverError(error: responseError)))
                } catch {
                    return completion(.failure(.invalidJSON(error)))
                }
            }
        }
        return request
    }
}
