//
//  ContentView.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var movieData:MovieData = MovieData()
    @State var showingScreen:Screens = .Main
    @State var movieDetail:Movie = mockMovieData
    @FetchRequest(sortDescriptors: []) var storedMovies: FetchedResults<StoredMovieData>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var storedMovieRep:StoredMovieRepresentation = StoredMovieRepresentation(title: "", releaseYear: 0, url: "")
    

    var body: some View {
        ScrollView(.vertical){
            VStack(spacing:10){
                if(movieData.movieDatasource.isEmpty && storedMovies.isEmpty){
                    VStack{
                        Spacer()
                        Text("Loading..")
                        Spacer()
                    }
                    .frame(height: UIScreen.screenHeight)
                } else {
                    switch showingScreen {
                    case .Main:
                        MainScreen(storedMovieList: storedMovies, storedMovieRep: $storedMovieRep, movieList: $movieData.movieDatasource, screenToShow: $showingScreen, movieDetail: $movieDetail)

                        
                    case .MovieDetailScreen:
                        MovieDetailView(screenToShow: $showingScreen, movie: movieDetail)
                        
                    case .StoredMovieDetailScreen:
                        StoredMovieDetailScreen(storedMovie: storedMovieRep, screenToShow: $showingScreen)
                    }
                }
            }

            .onAppear(perform: {
                movieData.getMovieDatas()
            })
            .ignoresSafeArea()
        }
        .refreshable {
            movieData.getMovieDatas()
        }
        .ignoresSafeArea()//<- here
    }
}

#Preview {
    ContentView()
}
