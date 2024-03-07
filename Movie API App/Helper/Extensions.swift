//
//  Extensions.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import Foundation
import UIKit
import SwiftUI

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension View {
    func debugColor(_ color: Color) -> some View {
        self.background(color)
    }
    
    func debugRed() -> some View {
        self.debugColor(Color.red)
    }
    
    func debugGreen() -> some View {
        self.debugColor(Color.green)
    }
    
    func debugBlue() -> some View {
        self.debugColor(Color.blue)
    }
}


struct GradientBackground: ViewModifier {
    var startColor: Color
    var endColor: Color
    
    func body(content: Content) -> some View {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                       startPoint: .top,
                       endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
        .overlay(content)
    }
}

extension View {
    func gradientBackground(startColor: Color, endColor: Color) -> some View {
        self.modifier(GradientBackground(startColor: startColor, endColor: endColor))
    }
}
