//
//  ContentView.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var movieData:MovieData = MovieData()
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                if(movieData.movieDatasource.isEmpty){
                    Text("empty")
                } else {
                    ForEach(Array(movieData.movieDatasource.enumerated()), id: \.element) { (index, movie) in
                        Text("\(index) Movie is ")
                    }
                }
            }
            .onAppear(perform: {
                movieData.getMovieDatas()
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    d("count is : \(movieData.movieDatasource.count)")
                }
            })
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
        .refreshable {
            movieData.getMovieDatas()
        }
    }
}

#Preview {
    ContentView()
}
