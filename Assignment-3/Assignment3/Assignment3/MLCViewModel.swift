//
//  MLCViewModel.swift
//  Assignment3
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

//  all the variables needed for the MortgageLoanCalculater are defined here and can be accessed
//  Mortgage calculation happens here and guards the principal amount

import Foundation

class MLCViewModel : ObservableObject {
    @Published var principal: String = ""
    @Published var intrest: Double = 4.65
    @Published var num_years: Double = 10.0
    @Published var monthlyPayment: Double = 0
    @Published var errorMessage = ""
    @Published var showalert = false
        
    func calculateMonthlyPayment() {
        guard let principal = Double(principal) else {
            errorMessage = "Give valid Principal value"
            showalert = true
//            showresult = false
            return
        }
        
        guard principal >= 0 else{
            errorMessage = "Principal cannot be Negative Value"
            showalert = true
//            showresult = false
            return
        }
        
        let r = intrest / 1200
        let n = num_years * 12
        let numerator = (principal * r * pow(1 + r, n))
        let denominator = pow(1 + r, n) - 1
        monthlyPayment = numerator / denominator
    }
}
