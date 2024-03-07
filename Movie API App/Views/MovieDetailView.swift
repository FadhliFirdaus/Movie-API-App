//
//  MovieDetailView.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import Foundation
import SwiftUI

struct MovieDetailView:View {

    @Binding var screenToShow:Screens
    var storedMovie:StoredMovieData?
    var movie:Movie = mockMovieData
    

    var body : some View {
        ZStack{
            VStack(spacing:0){
                Rectangle()
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/8.5, alignment: .top)
                    .foregroundColor(Color.blue)
                Spacer()
            }
            VStack(spacing:0){
                Spacer()
                    .frame(height: getSafeAreaTop()/2)
                HStack(spacing:0){
                    Button(action: {
                        withAnimation {
                            screenToShow = .Main
                        }
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Circle()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.white.opacity(0.5)))
                    })
                    Spacer()
                }
                .padding(20)
                .padding(.top, 10)
                Image("mock")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: UIScreen.screenWidth - 60, height: UIScreen.screenHeight/3, alignment: .top)
                    .padding(15)
                if storedMovie != nil {
                    Text("\(movie.originalTitleText.text)")
                } else {
                    Text("\(storedMovie?.title ?? "")")
                }
                Spacer()
            }
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
    }
}
