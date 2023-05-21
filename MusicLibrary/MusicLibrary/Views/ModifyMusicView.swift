//
//  ModifyMusicView.swift
//  MusicLibrary
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI
import PhotosUI

struct ModifyMusicView: View {
    @Environment (\.managedObjectContext) var dbContext
    @Environment (\.dismiss) var dismiss
    @State private var inputArtist = ""
    @State private var inputTitle = ""
    @State private var inputYear = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var updated = false
//    @State private var album: Album? = nil
    let album: Album?

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                HStack{
                    Text("Name:")
                    TextField("Artist Name:", text: $inputArtist)
                        .textFieldStyle(.roundedBorder)
                }
                HStack{
                    Text("Title:")
                    TextField("Title Name:", text: $inputTitle)
                        .textFieldStyle(.roundedBorder)
                }
                HStack{
                    Text("Year:")
                    TextField("year", text: $inputYear)
                        .textFieldStyle(.roundedBorder)
                }
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                        
                        Text("Photo Library")
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
                if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        //.cornerRadius(16)
                        .padding()
                } else {
                    Image("nopicture")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }

                Spacer()
                
            }
            .padding()
            .navigationTitle("Add Album")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save"){
                        let newName = inputArtist.trimmingCharacters(in: .whitespaces)
                        let newTitle = inputTitle.trimmingCharacters(in: .whitespaces)
                        let year = Int32(inputYear)
                        if !newName.isEmpty && !newTitle.isEmpty {
                            Task(priority: .high){
                                await storeAlbum(title : newTitle, year: year!, artist: newName)
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            if album == nil {
                let album = Album(context: dbContext)
            }

            if !updated {
                
                inputArtist = album?.artist ?? ""
                inputTitle = album?.title ?? ""
                inputYear = album?.year != 0 ? "\(album!.year)" : ""
                selectedImageData = album?.cover
                updated = true
            }
        }
    }
    func storeAlbum(title: String, year: Int32, artist: String) async {
        await dbContext.perform {
//            let newAlbum = Album(context: dbContext)
            album?.title = title
            album?.year = year
            album?.artist = artist
            if selectedImageData != nil {
                album?.cover = selectedImageData
            } else {
                album?.cover = nil
            }
            
            do {
                try dbContext.save()
                dismiss()
            } catch {
                print(error)
            }
        }
    }
}

struct ModifyMusicView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyMusicView(album: nil)
    }
}




