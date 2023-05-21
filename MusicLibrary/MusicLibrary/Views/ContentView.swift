//
//  ContentView.swift
//  MusicLibrary
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var dbContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Album.title, order: .forward)], predicate: nil, animation: .default) private var listOfAlbums: FetchedResults<Album>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listOfAlbums) { album in NavigationLink(destination: ModifyMusicView(album : album), label: {AlbumRow(album: album).id(UUID())})
                    
                }
                .onDelete(perform: { indexes in
                    Task(priority: .high) {
                        await deleteBook(indexes: indexes)
                    }
                })
            }
            .listStyle(.plain)
            .navigationTitle("Albums")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Sort") {
                        Button("Sort by Title") {
                            let sort = SortDescriptor(\Album.title, order: .forward)
                            listOfAlbums.sortDescriptors = [sort]
                        }
                        
                        Button("Sort by Artist") {
                            let sort1 = SortDescriptor(\Album.artist, order: .forward)
                            let sort2 = SortDescriptor(\Album.year, order: .reverse)
                            listOfAlbums.sortDescriptors = [sort1, sort2]
                        }
                        
                        Button("Sort by Year") {
                            let sort1 = SortDescriptor(\Album.year, order: .reverse)
                            let sort2 = SortDescriptor(\Album.artist, order: .forward)
                            listOfAlbums.sortDescriptors = [sort1, sort2]
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InsertAlbumView(), label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        
    }
    
    func deleteBook(indexes: IndexSet) async {
        await dbContext.perform {
            for index in indexes {
                dbContext.delete(listOfAlbums[index])
            }
            
            do {
                try dbContext.save()
            } catch {
                print(error)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
