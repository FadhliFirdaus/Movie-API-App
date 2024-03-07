    //
    //  PinterestCardView.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 07/03/2024.
    //

import Foundation
import SwiftUI

struct PinterestCardView : View {
    @State var movie:Movie = mockMovieData
    @State var imageRes:Image? = nil
    let urlString:String
    
    var body : some View {
        
        RoundedRectangle(cornerRadius: 3)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 0.5, x: 0, y: 0)
            .frame(width: UIScreen.screenWidth/2 - 30, height: UIScreen.screenHeight / 3, alignment: .center)
            .overlay {
                VStack(spacing:0){
                    if let imageRetrieved = imageRes {
                        imageRetrieved
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth/2 - 30, height: UIScreen.screenHeight / 6, alignment: .center)
                            .mask(CustomTopRoundedRectangle(radius: 3))
                    } else {
                        Image("mock")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth/2 - 30, height: UIScreen.screenHeight / 6, alignment: .center)
                            .mask(CustomTopRoundedRectangle(radius: 3))
                    }
                    HStack {
                        Text("\(movie.titleText.text)")
                            .font(.headline)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(3)
                    HStack {
                        Spacer()
                        Text("Released : \(String(movie.releaseYear.year))")
                            .font(.footnote)
                    }
                    .padding(3)
                    Text("\(movie.primaryImage?.caption.plainText ?? "")")
                        .font(.caption)
                        .lineLimit(4)
                        .truncationMode(.tail)
                    Spacer()
                }
            }
            .onAppear(perform: {
                loadImage()
            })
            
        
        
    }
    
    func loadImage() {
        guard let imageUrl = URL(string: urlString) else { return }
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
        }.resume()
    }
}


struct PinterestCardViewStoredMovie : View {
    var movie:StoredMovieData?
    var body : some View {
        RoundedRectangle(cornerRadius: 3)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 0.5, x: 0, y: 0)
            .frame(width: UIScreen.screenWidth/2 - 30, height: UIScreen.screenHeight / 3, alignment: .center)
            .overlay {
                VStack(spacing:0){
                    Image("mock")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth/2 - 30, height: UIScreen.screenHeight / 6, alignment: .center)
                        .mask(CustomTopRoundedRectangle(radius: 3))
                    
                    HStack {
                        Text("\(movie?.title ?? "")")
                            .font(.headline)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(3)
                    
                    HStack {
                        Spacer()
                        Text("Released : \(String(movie?.yearReleased ?? 1900))")
                            .font(.footnote)
                    }
                    .padding(3)
                    Text("\(movie?.title ?? "")")
                        .font(.caption)
                        .lineLimit(4)
                        .truncationMode(.tail)
                    Spacer()
                }
            }
            
    }
    
}

#Preview(body: {
    PinterestCardView(urlString: mockMovieData.primaryImage?.url ?? "")
})
