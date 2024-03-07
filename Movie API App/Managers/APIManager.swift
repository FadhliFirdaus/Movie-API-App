//
//  APIManager.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    let bareURLString = "https://moviesdatabase.p.rapidapi.com/titles"
    let movieURL = NSURL(string: "https://moviesdatabase.p.rapidapi.com/titles")! as URL

    let rapidAPIHeaders = [
        "X-RapidAPI-Key": "1c04b634dbmsh8f3ba3a3271a852p132851jsnab2307598441",
        "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
    ]
    
}
