//
//  Helper.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import Foundation

func variableName<T>(_ variable: T) -> String {
    let name = String(describing: Mirror(reflecting: variable).subjectType)
    return name
}

