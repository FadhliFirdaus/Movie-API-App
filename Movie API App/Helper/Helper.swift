    //
    //  Helper.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 06/03/2024.
    //

import Foundation
import SwiftUI

func variableName<T>(_ variable: T) -> String {
    let name = String(describing: Mirror(reflecting: variable).subjectType)
    return name
}

func getSafeAreaTop()->CGFloat{
    
    let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    
    return keyWindow?.safeAreaInsets.top ?? 0
    
}


struct CustomTopRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
            // Top-left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(
            center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
            radius: radius,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
            // Top-right corner
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(
            center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
            radius: radius,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        
            // Bottom-right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
            // Bottom-left corner
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        
        return path
    }
}
