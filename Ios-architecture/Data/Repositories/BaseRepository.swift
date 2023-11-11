//
//  BaseRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/30.
//

import Foundation
import Moya

class BaseRepository<T: TargetType> {

    init(_ environment: Environment = .prod) {
        if environment == .local {
            let customEndpointClosure = { (target: T) -> Endpoint in return Endpoint(url: URL(target: target).absoluteString,
                                                                                     sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                                                                     method: target.method,
                                                                                     task: target.task,
                                                                                     httpHeaderFields: target.headers)}
            self.provider = MoyaProvider<T>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        } else if ProcessInfo.processInfo.arguments.contains("isUITestingLoggedIn") || ProcessInfo.processInfo.arguments.contains("isUITestingLoggedOut") {
            let customEndpointClosure = { (target: T) -> Endpoint in return Endpoint(url: URL(target: target).absoluteString,
                                                                                     sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                                                                     method: target.method,
                                                                                     task: target.task,
                                                                                     httpHeaderFields: target.headers)}
            self.provider = MoyaProvider<T>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        } else {
            self.provider = MoyaProvider<T>(session: Session(interceptor: NetworkInterceptor.shared), plugins: [NetworkPlugin.shared])
        }
    }

    var provider: MoyaProvider<T>
}
