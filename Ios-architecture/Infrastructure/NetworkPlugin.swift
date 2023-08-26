//
//  NetworkPlugin.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/20.
//

import Foundation
import Moya

class NetworkPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(_):
//            if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
//                Log.network(json)
//            }
            break
        case .failure(_):
            break
        }
    }
}
