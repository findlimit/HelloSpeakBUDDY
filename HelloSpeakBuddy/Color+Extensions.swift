//
//  Color+Extensions.swift
//  HelloSpeakBuddy
//
//  Created by Peter Hsu on 2025/2/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove the '#' if it exists
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        let stringCounts = [6, 8]
        
        // Check that the string is a valid hex color
        guard stringCounts.contains(hexSanitized.count), let hexValue = Int(hexSanitized, radix: 16) else {
            self.init(.green)  // Fallback color if the hex string is invalid
            return
        }
        
        if hexSanitized.count == 8 {
            self.init(hex: (hexValue & 0xFFFFFF00) >> 8, opacity: Double(hexValue & 0x000000FF) / 255.0)
        } else {
            self.init(hex: hexValue)
        }
    }
    
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: opacity
        )
    }
}
