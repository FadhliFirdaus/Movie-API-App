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
    var movie:Movie?
    @State var imageRes:Image?
    @Environment(\.managedObjectContext) var viewContext
    
    
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
                        Text("\(movie?.titleText.text ?? "")")
                    }
                    
                    let day = movie?.releaseDate?.day as? Int ?? 0
                    let month = movie?.releaseDate?.month ?? 0
                    let year = movie?.releaseYear.year ?? 0
                    let releaseString = day == 0 ? "":"\(day) "
                    let monthString = month == 0 ? releaseString:releaseString + " \(monthName(for: month)) "
                    let fullString = monthString + "\(year)"
                    
                    Section(header: Text("Dates")) {
                        
                        Text("Date Released: \(fullString)")
                    }
                }
                
                Button(action: {
                    saveToCoreData()
                }, label: {
                    Text("Save to local storage")
                })
                .buttonStyle(.borderedProminent)
                .padding(24)
                Spacer()
            }
            .padding(.top, getSafeAreaTop())
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
        .onAppear(perform: {
            loadImage(urlString: movie?.primaryImage?.url ?? "")
        })
    }
    
    func saveToCoreData() {
        let storedMovie = StoredMovieData(context: viewContext)
        
            // Check if movie and primaryImage are not nil
        if let movie = movie, let primaryImage = movie.primaryImage {
            storedMovie.title = movie.titleText.text
            storedMovie.yearReleased = Int16(movie.releaseYear.year ?? 0)
            
                // Print the URL before assignment
            print("URL before assignment: \(primaryImage.url ?? "nil")")
            
            storedMovie.url = primaryImage.url
            
                // Print the URL after assignment
            print("URL after assignment: \(storedMovie.url ?? "nil")")
            
            do {
                try viewContext.save()
                print("done save")
            } catch {
                print("Error saving MovieEntity to Core Data: \(error.localizedDescription)")
            }
        } else {
            print("Movie or primaryImage is nil")
        }
    }

    
    
    func loadImage(urlString:String) {
        print(urlString)
        guard let imageUrl = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                if let uiImage = UIImage(data: data) {
                    imageRes = Image(uiImage: uiImage)
                }
            }
        }
        .resume()
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
