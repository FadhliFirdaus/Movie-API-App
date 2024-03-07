    //
    //  MovieDetailScreen.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 06/03/2024.
    //

import Foundation
import SwiftUI


struct MainScreen: View {
    var storedMovieList: FetchedResults<StoredMovieData>
    @Binding var movieList:[Movie]
    @Binding var screenToShow:Screens
    @Binding var movieDetail:Int
    @State var searchText:String = ""
    var body: some View {
        VStack{
            VStack{
                HStack{
                    TextField("Search a movie from year", text: $searchText)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/10, alignment: .leading)
                        .padding(5)
                    Button {
                        if let year = Int(searchText), (1900...2024).contains(year) {
                            print("Valid year: \(year)")
                            MovieData().getMovieDataWithParams(year: year)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                }
                if storedMovieList.isEmpty {
                    ForEach(Array(movieList.enumerated()), id: \.element) { (index, movie) in
                        Text("\(index) API Movie is \(movie.titleText.text)")
                            .onTapGesture {
                                movieDetail = index
                                screenToShow = .MovieDetailScreen
                            }
                    }
                } else {
                    ForEach(Array(storedMovieList.enumerated()), id: \.element) { (index, movie) in
                        Text("\(index) Stored Movie is \(movie.title!)")
                            .onTapGesture {
                                movieDetail = index
                                screenToShow = .MovieDetailScreen
                            }
                    }
                }
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/10)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
    }
}

