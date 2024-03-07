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
        VStack(spacing:0){
            VStack(spacing:0){
                HStack(spacing:0){
                    TextField("Search a movie from year i.e 2014", text: $searchText)
                        .frame( height: UIScreen.screenHeight/10, alignment: .leading)
                        .padding(5)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        if let year = Int(searchText), (1900...2024).contains(year) {
                            MovieData().getMovieDataWithParams(year: year)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                            .scaleEffect(0.6)
                    }
                }
                .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight/10, alignment: .center)
                
                if storedMovieList.isEmpty {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                        ForEach(Array(movieList.enumerated()), id: \.element) { (index, movie) in
                            PinterestCardView(movie: movie, urlString: movie.primaryImage?.url ?? "")
                                .onTapGesture {
                                    movieDetail = index
                                    screenToShow = .MovieDetailScreen
                                }
                        }
                    }
                } else {
                    ForEach(Array(storedMovieList.enumerated()), id: \.element) { (index, movie) in
                        PinterestCardViewStoredMovie(movie: movie)
                            .onTapGesture {
                                movieDetail = index
                                screenToShow = .MovieDetailScreen
                            }
                    }
                }
                Spacer()
            }
            .frame(width: UIScreen.screenWidth, alignment: .top)
            .padding(6)
            
        }
        .frame(width: UIScreen.screenWidth, alignment: .top)
        .padding(12)
        .background {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.black.opacity(0.05)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

