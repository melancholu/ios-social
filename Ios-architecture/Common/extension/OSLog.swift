//
//  OSLog.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import OSLog

extension OSLog {
    private static let identifier = Bundle.main.bundleIdentifier ?? ""

    static let debug = OSLog(subsystem: identifier, category: "Debug")
    static let info = OSLog(subsystem: identifier, category: "Info")
    static let network = OSLog(subsystem: identifier, category: "Network")
    static let error = OSLog(subsystem: identifier, category: "Error")
}

struct Log {
    enum Level {
        case debug
        case info
        case network
        case error

        fileprivate var category: String {
            switch self {
            case .debug:
                return "Debug"
            case .info:
                return "Info"
            case .network:
                return "Network"
            case .error:
                return "Error"
            }
        }

        fileprivate var osLog: OSLog {
            switch self {
            case .debug:
                return OSLog.debug
            case .info:
                return OSLog.info
            case .network:
                return OSLog.network
            case .error:
                return OSLog.error
            }
        }

        fileprivate var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .network:
                return .default
            case .error:
                return .error
            }
        }
    }

    static private func log(_ message: Any, _ arguments: [Any], level: Level) {
        let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
        os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message) \(extraMessage)")
    }

    static func debug(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .debug)
    }

    static func info(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .info)
    }

    static func network(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }

    static func error(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }
}
