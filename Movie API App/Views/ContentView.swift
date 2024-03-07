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
    @State var movieDetailIndex = -1
    @FetchRequest(sortDescriptors: []) var storedMovies: FetchedResults<StoredMovieData>
    @Environment(\.managedObjectContext) var managedObjectContext
    

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
                        MainScreen(storedMovieList: storedMovies, movieList: $movieData.movieDatasource, screenToShow: $showingScreen, movieDetail: $movieDetailIndex)

                        
                    case .MovieDetailScreen:
                        MovieDetailView(screenToShow: $showingScreen, storedMovie: storedMovies.count > movieDetailIndex ? storedMovies[movieDetailIndex] : nil, movie: movieData.movieDatasource[movieDetailIndex])

                            .onAppear {
                                for movie in movieData.movieDatasource {
                                    let storedMovie = StoredMovieData(context: managedObjectContext)
                                    storedMovie.title = movie.titleText.text
                                    storedMovie.yearReleased = Int16(movie.releaseYear.year)
                                }
                                do {
                                    try managedObjectContext.save()
                                } catch {
                                    print("Error saving CoreData: \(error.localizedDescription)")
                                }
                            }
                    }
                }
            }

            .onAppear(perform: {
                if(storedMovies.isEmpty){
                    movieData.getMovieDatas()
                }
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
