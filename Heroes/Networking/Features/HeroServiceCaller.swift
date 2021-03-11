//
//  HeroServiceCaller.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation
import Alamofire

final class HeroServiceCaller {
    private let serviceRequester = ServiceRequester()
    
    private func getHeroBy(id: Int, completion: @escaping (Result<Hero, NetworkError>) -> Void) -> DataRequest {
        let router = HeroRouter.getHero(id: id)
        let request = serviceRequester.request(router: router) { (result) in
            completion(result)
        }
        return request
    }
    
    func getHeroesFrom(ids: [Int], completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        var heroes = [Hero]()
        var chain = [DataRequest]()
        for id in ids {
            let request = getHeroBy(id: id) { result in
                switch result {
                    case .success(let heroe):
                        heroes.append(heroe)
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
            chain.append(request)
        }
        let requestChain = RequestChain(requests: chain)
        requestChain.start { done, error in
            if done {
                heroes.sort { (first, second) -> Bool in
                    return Int(first.id) ?? 0 < Int(second.id) ?? 0
                }
                completion(.success(heroes))
            } else {
                if let error = error?.error {
                    completion(.failure(.unknown(error)))
                }
            }
        }
    }
}
