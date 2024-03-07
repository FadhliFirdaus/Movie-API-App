    //
    //  StoredMovieDetailScreen.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 08/03/2024.
    //

import Foundation
import SwiftUI

struct StoredMovieDetailScreen : View {
    var storedMovie:StoredMovieRepresentation
    @Binding var screenToShow:Screens
    @State var imageRes:Image? = nil

    var body : some View {
        ZStack{
            VStack(spacing:0){
                Rectangle()
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/8.5, alignment: .top)
                    .foregroundColor(Color.orange.opacity(0.3))
                Spacer()
            }
            
            VStack(spacing:0){
                HStack{
                    Spacer()
                    Text("Movie Detail")
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, getSafeAreaTop())
            .padding(20)
            VStack(spacing:0){
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
                
               
                if let imageRes = imageRes {
                    imageRes
                        .resizable()
                        .scaledToFit()
                        .frame(height: UIScreen.screenHeight/2.5, alignment: .center)
                        .padding(.top, 30)
                } else {
                    RoundedRectangle(cornerRadius: 3)
                        .overlay {
                            Image("mock")
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(height: UIScreen.screenHeight/2.5, alignment: .center)
                        .clipped()
                        .padding(.top, 30)
                }
                List {
                    Section(header: Text("Title")) {
                        Text("\(storedMovie.title)")
                    }
                    
                    Section(header: Text("Dates")) {
                        
                        Text("Date Released: \(String(storedMovie.releaseYear))")
                    }
                }
                Spacer()
            }
            .padding(.top, getSafeAreaTop())
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
        .onAppear(perform: {
            loadImage(urlString: storedMovie.url)
        })
    }
    
    
    
    func loadImage(urlString:String) {
        guard let imageUrl = URL(string: urlString) else {
            d("image url can't be parsed")
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                if let uiImage = UIImage(data: data) {
                    self.imageRes = Image(uiImage: uiImage)
                }
            }
        }
        .resume()
    }
    
}
