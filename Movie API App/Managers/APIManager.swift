//
//  APIManager.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let movieURL = NSURL(string: "https://moviesdatabase.p.rapidapi.com/titles")! as URL

    let rapidAPIHeaders = [
        "X-RapidAPI-Key": "1c04b634dbmsh8f3ba3a3271a852p132851jsnab2307598441",
        "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
    ]
    
}

struct MovieParams {
    let genre:String
    let startYear:Int
    let titleType:String
    let list:String
    let year:Int
    let sort:String
    let page:String
    let info:String
    let endYear:Int
    let limit:String
    
    init(genre: String = "", startYear: Int = 0, titleType: String = "", list: String = "", year: Int = 0, sort: String = "", page: String = "", info: String = "", endYear: Int = 0, limit: String = "") {
        self.genre = genre
        self.startYear = startYear
        self.titleType = titleType
        self.list = list
        self.year = year
        self.sort = sort
        self.page = page
        self.info = info
        self.endYear = endYear
        self.limit = limit
    }
    
    func getOptionalURL() -> String {
        var optionalURL = ""
        let vars:[Any] = [genre, startYear, titleType, list, year, sort, page, info, endYear, limit]
        
        for param in vars {
            if param is Int {
                if(param as! Int != 0){
                    optionalURL += "?\(variableName(param))=\(param)"
                }
            }
            if param is String {
                if (param as! String != ""){
                    optionalURL += "?\(variableName(param))=\(param)"
                }
            }
        }
        return optionalURL
    }
}
