//
//  InsertAlbumView.swift
//  MusicLibrary
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI
import PhotosUI

struct InsertAlbumView: View {
    @Environment(\.managedObjectContext) var dbContext
    @Environment(\.dismiss) var dismiss
    
    @State private var inputTitle = ""
    @State private var inputArtist = ""
    @State private var inputYear = ""
    
    @State var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    Text("Title:")
                    TextField("Insert title", text: $inputTitle)
                        .textFieldStyle(.roundedBorder)
                }

                HStack {
                    Text("Year:")
                    TextField("Insert year", text: $inputYear)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                }

                HStack {
                    Text("Artist:")
                    TextField("Insert author", text: $inputArtist)
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
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newTitle = inputTitle.trimmingCharacters(in: .whitespaces)
                        let newYear = Int32(inputYear)
                        let newArtist = inputArtist.trimmingCharacters(in: .whitespaces)
                        if !newTitle.isEmpty && !newArtist.isEmpty && newYear != nil {
                            Task(priority: .high) {
                                await storealbum(title: newTitle, year: newYear!, artist: newArtist)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func storealbum(title: String, year: Int32, artist: String) async {
        await dbContext.perform {
            let newAlbum = Album(context: dbContext)
            newAlbum.title = title
            newAlbum.year = year
            newAlbum.artist = artist
            if selectedImageData != nil {
                newAlbum.cover = selectedImageData
            } else {
                newAlbum.cover = nil
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

struct InsertAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        InsertAlbumView()
    }
}
