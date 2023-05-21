//
//  Album+ViewModel.swift
//  MusicLibrary
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107


import Foundation
import UIKit

extension Album {
    
    var showTitle: String {
        return title ?? "Undefined"
    }
    
    var showYear: String {
        return String(year)
    }
    
    var showArtist: String {
        return artist ?? "Undefined"
    }
    
    var showCover: UIImage {
        if let data = cover, let image = UIImage(data: data) {
            return image
        } else {
            return UIImage(named: "nopicture")!
        }
    }
}

