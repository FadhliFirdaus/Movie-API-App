    //
    //  MovieDetailScreen.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 06/03/2024.
    //

import Foundation
import SwiftUI


struct MainScreen: View {
    @ObservedObject var movieData:MovieData = MovieData()
    var storedMovieList: FetchedResults<StoredMovieData>
    @Binding var storedMovieRep:StoredMovieRepresentation
    @Binding var movieList:[Movie]
    @Binding var screenToShow:Screens
    @Binding var movieDetail:Movie
    @State var searchText:String = ""
    @State var selectedTab:Tabs = .Browse
    @State var showSheet = false
    
    var body: some View {
        @State var text = movieData.stringRep
        VStack(spacing:0){
            VStack(spacing:0){
                HStack(spacing:0){
                    TextField("Search a movie from year i.e 2014", text: $searchText)
                        .frame( height: UIScreen.screenHeight/10, alignment: .leading)
                        .padding(5)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        if let year = Int(searchText), (1900...2024).contains(year) {
                            self.movieData.getMovieDataWithParams(year: year)
                            showSheet.toggle()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                            .scaleEffect(0.6)
                    }
                    .sheet(isPresented: $showSheet, content: {
                        if(movieData.stringRep == ""){
                            Text("empty")
                        } else {
                            ScrollView(.vertical){
                                Text("\(movieData.stringRep)")
                            }
                        }
                    })
                }
                .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight/10, alignment: .center)
                
                Picker("Selection", selection: $selectedTab, content: {
                    ForEach(Tabs.allCases, id: \.self) {tab in
                        Text(tab.rawValue)
                    }
                })
                .pickerStyle(.segmented)
                .padding([.leading, .trailing], 24)
                .zIndex(2)
                VStack(spacing:0){
                    if selectedTab == .Browse {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                            ForEach(Array(movieList.enumerated()), id: \.element) { (index, movie) in
                                PinterestCardView(movie: movie, urlString: movie.primaryImage?.url ?? "")
                                    .onTapGesture {
                                        screenToShow = .MovieDetailScreen
                                        movieDetail = movie
                                    }
                            }
                        }
                    } else {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                            ForEach(Array(storedMovieList.enumerated()), id: \.element) { (index, movie) in
                                PinterestCardViewStoredMovie(movie: movie)
                                    .onTapGesture {
                                        screenToShow = .StoredMovieDetailScreen
                                        storedMovieRep = StoredMovieRepresentation(title: movie.title ?? "", releaseYear: Int(movie.yearReleased), url: movie.url ?? "")
                                    }
                            }
                        }
                    }
                }
                .padding(.top, 15)
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

