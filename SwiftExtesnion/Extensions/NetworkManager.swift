//
//  NetworkManager.swift
//  SwiftTs
//
//  Created by Xinbo Lian on 2020/12/20.
//

import Foundation
import Moya


struct NetworkManager<R:Moya.TargetType,S:Codable> {
    
    enum NetworkError :Error{
        case parseModelError(String)
        case systemNetworkError(Error)
        case serverError
    }
    
    
    typealias NetworkCompletion = (Result<S, NetworkError>) -> Void
    func request(target: R, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping NetworkCompletion)
    {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default

        let provider = MoyaProvider<R>(callbackQueue: callbackQueue,session: Session(configuration: configuration, startRequestsImmediately: false))
        provider.request(target) { (result) in
            switch result{
            case .success(let response):
                do {
                    let value = try response.map(BaseModel<S>.self)
                    if value.code == 200 {
                        completion(.success(value.data))
                    }else
                    {
                        completion(.failure(.serverError))
                    }
                    
                } catch  {
                    completion(.failure(.parseModelError(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(.systemNetworkError(error)))
            }
        }
    }
}

struct BaseModel<T:Codable> : Codable {
    let data :T
    let code :Int
}

/*
 NetworkManager<Request,[String]>().request(target: .test("2")) { (res) in
     switch res
     {
     case .success(let value):
         break
     case .failure(let error):
         break
     }
 }
*/
