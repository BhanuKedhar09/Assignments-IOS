//
//  presidentsListViewModel.swift
//  PresidentsUSA
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

//  This the PresidentsListViewModel reads from plist and sort by president number.

import Foundation

class PresidentListViewModel : ObservableObject {
    
    @Published var presidents: [PresidentViewModel] = []
    
    func loadPropertyList() {
        guard let path = Bundle.main.path(forResource: "presidents", ofType: "plist"), let xml = FileManager.default.contents(atPath: path) else {
            fatalError("Unable to access property list presidents.plist")
        }
        
        do {
            var presidents = try PropertyListDecoder().decode([President].self, from: xml)
            
            presidents.sort {
                $0.number < $1.number
            }
            
            self.presidents = presidents.map(PresidentViewModel.init)
            
        } catch {
            fatalError("Unable to decode property list presidents.plist")
        }
    }
}





