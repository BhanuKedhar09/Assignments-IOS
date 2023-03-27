//
//  TemperatureConversionView.swift
//  Assignment3
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI

struct TemperatureConversionView: View {
//    var temperatures = [Array(-129...134), Array(-90...57)]
//
//    @State private var selectedSetting = 0
//    @State private var selected = 32
//    @State private var selectedc = 19
//    @State private var showAlert = false
    
    @StateObject private var viewModel = TcViewModel()
    
    var body: some View {
        VStack{
            Text("Temperature Conversion")
                .font(.title2)
                .bold()
            
            Picker("Setting", selection: $viewModel.selectedSetting) {
                Text("\u{2109} \u{2B62} \u{2103}").tag(0)
                Text("\u{2103} \u{2B62} \u{2109}").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if viewModel.selectedSetting == 0 {
                Picker("Fahrenheit to Celsius", selection: $viewModel.selected) {
                    ForEach(viewModel.temperatures[viewModel.selectedSetting], id: \.self) {
                            Text("\($0) \u{2109}")
                        }
                    }
                    .pickerStyle(.wheel)
                let c = viewModel.fahrenheitToCelsius()
                Text("\(c, specifier: "%.2f") \u{2103}")
                        .font(.title3)
                        .bold()
                        } else {
                            Picker("Celsius to Fahrenheit", selection: $viewModel.selectedc) {
                                ForEach(viewModel.temperatures[viewModel.selectedSetting], id: \.self) {
                                    Text("\($0) \u{2103}")
                                }
                            }
                            .pickerStyle(.wheel)
                            let f = viewModel.CelsiusToFarenheit()
                            Text("\(f, specifier: "%.2f") \u{2109}")
                                .font(.title3)
                                .bold()
                        }
            Spacer()
        }
    }
}

//func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
//    return (fahrenheit - 32) * 5/9
//}
//
//func CelsiusToFarenheit(_ celsius: Double) -> Double {
//    return (celsius * (9/5)) + 32
//}

struct TemperatureConversionView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversionView()
    }
}
