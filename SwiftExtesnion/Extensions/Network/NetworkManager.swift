//
//  NetworkManager.swift
//  SwiftTs
//
//  Created by Xinbo Lian on 2020/12/20.
//

import Foundation
import Moya

public struct NetworkManager<R:RequestTarget,S:ResponseTarget> {
    
    enum NetworkError :Error{
        case parseModelError(String)
        case systemNetworkError(Error)
        case serverError
    }
    
    typealias NetworkCompletion = (Result<S, NetworkError>) -> Void
    
    typealias NetworkListCompletion = (Result<[S], NetworkError>) -> Void
    
    func request(target: R, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping NetworkCompletion) {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        // simpleData
//        let provider = MoyaProvider<R>(stubClosure: MoyaProvider<R>.immediatelyStub, callbackQueue: callbackQueue,session: Session(configuration: configuration, startRequestsImmediately: false))
        let provider = MoyaProvider<R>(callbackQueue: callbackQueue,session: Session(configuration: configuration))
        provider.request(target) { (result) in
            switch result{
            case .success(let response):
                do {
                    print(Thread.current)
                    let returnValue = try response.map(S.Parser.self)
                    if returnValue.code == 200 {
                        completion(.success(returnValue.value))
                    }else {
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
    
    func requestData(target: R, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping NetworkCompletion) {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        let provider = MoyaProvider<R>(callbackQueue: callbackQueue,session: Session(configuration: configuration))
        provider.request(target) { (result) in
            switch result{
            case .success(let response):
                do {
                    let returnValue = try response.map(BaseModel<S>.self)
                    if returnValue.code == 200 {
                        completion(.success(returnValue.value))
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
    
    func requestListData(target: R, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping NetworkListCompletion) {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        let provider = MoyaProvider<R>(callbackQueue: callbackQueue,session: Session(configuration: configuration))
        provider.request(target) { (result) in
            switch result{
            case .success(let response):
                do {
                    let returnValue = try response.map(BaseListModel<S>.self)
                    if returnValue.code == 200 {
                        completion(.success(returnValue.rows))
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
