//
//  AlbumRow.swift
//  MusicLibrary
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI

struct AlbumRow: View {
    let album : Album
    var body: some View{
        HStack(alignment: .top){
            Image(uiImage: album.showCover)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .cornerRadius(10)
            VStack(alignment: .leading){
                Text(album.showTitle)
                    .bold()
                Text(album.showArtist)
                    .bold()
                Text(album.showYear)
                    .font(.caption)
                
            }
            .padding(.top, 5)
            
            Spacer()
            
        }
    }
}

struct AlbumRow_Previews: PreviewProvider {
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var album : Album {
        let album = Album(context: viewContext)
        album.title = "Some Title"
        album.artist = "Random Guy"
        album.year = 2023
        album.cover = nil
        
        return album
    }
    
    static var previews: some View {
        AlbumRow(album: album)
            .previewLayout(.sizeThatFits)
    }
}
