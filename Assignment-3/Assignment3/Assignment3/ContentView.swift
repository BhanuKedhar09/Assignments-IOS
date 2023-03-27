//
//  ContentView.swift
//  Assignment3
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            TemperatureConversionView()
                .tabItem{
                    Label("Temperature", image: "Temperature")
                }
            MortgageLoanCalculater()
                .tabItem{
                    Label("Mortgage", image: "House")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
