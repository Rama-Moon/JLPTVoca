//
//  Color+Extension.swift
//  JLPTVoca
//
//  Created by Rama on 9/11/25.
//

import SwiftUI

extension Color {
    static let coral30 = Color(hex: "FFA091")
    static let coral50 = Color(hex: "FF715B")
    static let coral70 = Color(hex: "B55041")
    static let orange0 = Color(hex: "F7F2EF")
    static let orange20 = Color(hex: "FFF4EE")
    static let orange30 = Color(hex: "FFDFCC")
    static let orange40 = Color(hex: "FFBF9B")
    static let orange50 = Color(hex: "FF9D65")
    
    static let yellow = Color(hex: "FFFF42")
    static let star = Color(hex: "FFD042")
    
    static let sukdal = Color(hex: "FFD79F")
    static let seotull = Color(hex: "8FE0A5")
    static let sedano = Color(hex: "8FBAFF")
    
    static let white0 = Color(hex: "FFFFFF")
    static let black5 = Color(hex: "F3F3F3")
    static let black10 = Color(hex: "F3F3F3")
    static let black20 = Color(hex: "EBEBEB")
    static let black30 = Color(hex: "C9C9C9")
    static let black50 = Color(hex: "9B9B9B")
    static let black70 = Color(hex: "575757")
    static let black100 = Color(hex: "000000")
}

public extension Color {

    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
