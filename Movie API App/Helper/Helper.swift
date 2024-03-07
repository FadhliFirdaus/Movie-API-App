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
