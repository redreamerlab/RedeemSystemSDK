//
//  DLog.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

func DLogDebug(_ string: Any? = String(), file: String = #file, line: Int = #line, function: String = #function) {
    print("📒 [\(Thread.current.description)] \(file.components(separatedBy: "/").last ?? String())[\(line)](\(function)): \(string ?? String())")
}

func DLogWarn(_ string: Any? = String(), file: String = #file, line: Int = #line, function: String = #function) {
    print("⚠️ [\(Thread.current.description)] \(file.components(separatedBy: "/").last ?? String())[\(line)](\(function)): \(string ?? String())")
}

func DLogInfo(_ string: Any? = String(), file: String = #file, line: Int = #line, function: String = #function) {
    print("ℹ️ [\(Thread.current.description)] \(file.components(separatedBy: "/").last ?? String())[\(line)](\(function)): \(string ?? String())")
}

func DLogError(_ string: Any? = String(), file: String = #file, line: Int = #line, function: String = #function) {
    print("🚨 [\(Thread.current.description)] \(file.components(separatedBy: "/").last ?? String())[\(line)](\(function)): \(string ?? String())")
}
