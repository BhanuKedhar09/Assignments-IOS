//
//  ContentView.swift
//  PresidentsUSA
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

// This the main view of the app
// I have also created a edit button and those remove and move functions are also written here.

import SwiftUI

struct PresidentsListView: View {
    
    @StateObject private var presidentListVM = PresidentListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(presidentListVM.presidents, id: \.name) {
                    presidentVM in
                    NavigationLink(destination: PresidentDetailView( president: presidentVM)) {
                        PresidentCell(president: presidentVM)
                    }
                }
                .onDelete(perform: deleteCharacter)
                .onMove(perform: moveCharacter)
                
            }
            .listStyle(.plain)
            .navigationTitle("Presidents")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            presidentListVM.loadPropertyList()
        }
    }
    
    func deleteCharacter(at offsets: IndexSet) {
        presidentListVM.presidents.remove(atOffsets: offsets)
    }
    
    func moveCharacter(from source: IndexSet, to destination: Int) {
        presidentListVM.presidents.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PresidentsListView()
    }
}
