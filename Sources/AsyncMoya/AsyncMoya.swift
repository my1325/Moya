//
//  File.swift
//  Moya
//
//  Created by mayong on 2024/12/10.
//

import Foundation
#if canImport(Moya)
import Moya
#endif

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension MoyaProvider {
    func requestAsync(
        _ target: Target,
        callbackQueue: DispatchQueue? = nil
    ) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            request(target, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
