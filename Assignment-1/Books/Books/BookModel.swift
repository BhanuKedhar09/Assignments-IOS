//
//  BookModel.swift
//  Books
//
//  Created by Sunku Bhanu Kedhar Nath on 2/11/23.
//
// team :
// Bhanu Kedhaar Nath Sunku (Z1974769)
// Yashwanth Raj Varikunta (Z1973107)

import Foundation

struct Book: Identifiable {
    let id =  UUID()
    var image : String
    var authors : String
    var title : String
    var edition : String
    var description : String
    var categories : [String] = []
    var price : Double
}
