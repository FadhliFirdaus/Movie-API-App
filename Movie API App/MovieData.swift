    //
    //  Observable.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 06/03/2024.
    //

import Foundation


class MovieData:ObservableObject {
    @Published var movieDatasource:[Movie] = []
    var year = -1
    
    func getMovieDatas(){
        let url = APIManager.shared.movieURL
        let headers = APIManager.shared.rapidAPIHeaders
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                d("error here")
            } else {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode{
                case 200:
                    if let responseData = data {
                        let mainResponse = try? JSONDecoder().decode(MainResponse.self, from: responseData)
                        if let wrappedResponse = mainResponse {
                            let movies: [Movie] = wrappedResponse.results.map { movieData in
                                return Movie(
                                    id: movieData.id,
                                    titleText: movieData.titleText,
                                    releaseYear: movieData.releaseYear,
                                    resultID: movieData.resultID,
                                    titleType: movieData.titleType,
                                    primaryImage: movieData.primaryImage,
                                    releaseDate: movieData.releaseDate,
                                    originalTitleText: movieData.originalTitleText)
                            }
                            DispatchQueue.main.async {
                                self.movieDatasource = movies
                            }
                        }
                    }
                default:
                    d("not 200")
                }
            }
        })
        dataTask.resume()
    }
    
    func getMovieDataWithParams(year:Int) {
        let url = NSURL(string: APIManager.shared.bareURLString + "?year=\(year)")! as URL
        let headers = APIManager.shared.rapidAPIHeaders
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                d("error here")
            } else {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode{
                case 200:
                    if let responseData = data {
                        let mainResponse = try? JSONDecoder().decode(MainResponse.self, from: responseData)
                        if let wrappedResponse = mainResponse {
                            let movies: [Movie] = wrappedResponse.results.map { movieData in
                                return Movie(
                                    id: movieData.id,
                                    titleText: movieData.titleText,
                                    releaseYear: movieData.releaseYear,
                                    resultID: movieData.resultID,
                                    titleType: movieData.titleType,
                                    primaryImage: movieData.primaryImage,
                                    releaseDate: movieData.releaseDate,
                                    originalTitleText: movieData.originalTitleText)
                            }
                            DispatchQueue.main.async {
                                self.movieDatasource = movies
                            }
                        }
                    }
                default:
                    d("not 200")
                }
            }
        })
        dataTask.resume()
    }
}
