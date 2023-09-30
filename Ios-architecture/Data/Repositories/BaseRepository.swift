//
//  BaseRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/30.
//

import Foundation
import Moya

class BaseRepository<T: TargetType> {
    let provider = MoyaProvider<T>(session: Session(interceptor: NetworkInterceptor.shared), plugins: [NetworkPlugin.shared])
}
