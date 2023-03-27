//
//  MortgageLoanCalculater.swift
//  Assignment3
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI

struct MortgageLoanCalculater: View {
//    @State var showresult = false
//    @State private var principal = ""{didSet{showresult = false}}
//    @State private var intrest = 4.65
//    @State private var num_years = 10.0
//    @State private var monthlyPayment: Double = 0
    @StateObject private var viewModel = MLCViewModel()
    var body: some View {
        VStack{
            Text("Loan Calculater")
                .font(.title)
                .bold()
                .padding()
            TextField("Enter Principal", text: $viewModel.principal)
                .keyboardType(.numbersAndPunctuation)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Stepper(value: $viewModel.intrest, in: 0.01...20.00, step: 0.01){
                Text("Interest")
                    .font(.title3)
                    .bold()
//                    .padding()
            }
                .padding(.horizontal)
            HStack{
                Text("Annual Rate")
                    .font(.title3)
                    .bold()
                    .padding()
                Spacer()
                Text("\(viewModel.intrest, specifier: "%.2f")%")
                    .font(.title3)
                    .bold()
                    .padding()
            }
            
            HStack{
                Text("Number of Years")
                    .font(.title3)
                    .bold()
                    .padding()
                Spacer()
                Text("\(viewModel.num_years, specifier: "%.0f") years")
                    .font(.title3)
                    .bold()
                    .padding()
            }
            
            Slider(value: $viewModel.num_years, in: 10.0...30.0, step:5, minimumValueLabel: Text("10"), maximumValueLabel: Text("30"), label: {Text("Number Of Years")
            })
                .padding(.horizontal)
            
            Button(action: {viewModel.calculateMonthlyPayment()}){
                Text("Calculate")
                    .bold()
                    .padding(12)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding()
            
            HStack{
                Text("Monthly Payment")
                    .bold()
                    .padding()
                Spacer()
                Text("$\(viewModel.monthlyPayment, specifier: "%.2f")")
                    .bold()
                    .padding()
            }
            .alert(isPresented: $viewModel.showalert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage)
                )
            }
            
            Spacer()
        }
    }
}


//func MortgageCalculater(principal: Double, intrest: Double, num_years: Double) -> Double {
//    let r = intrest / 1200
//    let n = num_years * 12
//    return (principal * r * pow(1 + r, n)) / (pow(1 + r, n) - 1)
//}


struct MortgageLoanCalculater_Previews: PreviewProvider {
    static var previews: some View {
        MortgageLoanCalculater()
    }
}
