//
//  PresidentDetailView.swift
//  PresidentsUSA
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

//  This is the detailed view of the president the defalt is the George washinton's detailed view. The default values are taken from PresidentViewModel.

import SwiftUI

struct PresidentDetailView: View {
    
    var president: PresidentViewModel
    
    var body: some View {
        VStack(spacing:12) {
            Text(president.name)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
            
            Text("\(president.ordinalNumber) President of the United States of America")
                .fontWeight(.semibold)

            Text("(\(president.startDate) to \(president.endDate))")
            
            Spacer()
            
            Image("seal")
                .resizable()
                .scaledToFit()
                .cornerRadius(16)
                .padding(.horizontal)
            
            Spacer()
            
            Text("Nickname")
                .fontWeight(.semibold)
                .font(.callout)
                            
            Text("\(president.nickname)")
                .padding(5)
                .multilineTextAlignment(.center)

            
            
            
            if president.politicalParty != "None"{
                Text("Political Party")
                    .fontWeight(.semibold)
                Text(president.politicalParty)
            }

        }
    }
}

struct PresidentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PresidentDetailView(president: PresidentViewModel.default)
    }
}
