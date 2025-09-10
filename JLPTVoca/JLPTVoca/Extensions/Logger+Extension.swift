//
//  Logger+Extension.swift
//  JLPTVoca
//
//  Created by Rama on 9/9/25.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let word = Logger(subsystem: subsystem, category: "Word")
}
