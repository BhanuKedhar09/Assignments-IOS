//
//  TCViewModel.swift
//  Assignment3
//
//  Created by Sunku Bhanu Kedhar Nath on 3/27/23.
//
// This is the swift file where temperature converion happens
// all the variables are defined here and can be accessed in view

import Foundation


class TcViewModel : ObservableObject {
    @Published  var temperatures = [Array(-129...134), Array(-90...57)]
    @Published  var selectedSetting = 0
    @Published  var selected = 32
    @Published  var selectedc = 19
    @Published  var showAlert = false
    
    
    func fahrenheitToCelsius() -> Double {
//        let celsius = (selected - 32) * (5.0/9.0)
        return Double((Double(selected) - 32.0) * (5.0/9.0))
    }

    func CelsiusToFarenheit() -> Double {
//        let farenheit = (selectedc * (9.0/5.0)) + 32
        return Double((Double(selectedc) * (9/5)) + 32.0)
    }
    
}
