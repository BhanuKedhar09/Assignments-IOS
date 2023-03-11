//
//  DogAgeViewModel.swift
//  DogAgeApp
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import Foundation

class DogAgeViewModel: ObservableObject {
    
    @Published var resultText = "0.00"
    @Published var errorMessage = ""
    @Published var showalert = false
    @Published var age = ""{didSet{showresult = false}}
    @Published var showresult = false
    
    func computehumanage() {
        guard let age = Double(age) else {
            errorMessage = "Please enter a valid age for your dog"
            showalert = true
            showresult = false
            return
        }
        guard age >= 0 else {
            errorMessage = "Please enter a valid age for your dog"
            showalert = true
            showresult = false
            return
        }
        var result: Int
        result = Int(((log(age))*16 + 31))
        resultText = String(result)
    }
}


