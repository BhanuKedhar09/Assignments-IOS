//
//  PresidentCell.swift
//  PresidentsUSA
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

//  This is the list view. Default is George washington. this single list view the content view will show all the lists together.

import SwiftUI

struct PresidentCell: View {
    
    var president: PresidentViewModel
    
    var body: some View {
        HStack {
//            Image(president.name)
//                .resizable()
//                .frame(width: 50, height: 50)
//                .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text(president.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text(president.politicalParty)
                    .font(.subheadline)
            }
        }
    }
}

struct PresidentCell_Previews: PreviewProvider {
    static var previews: some View {
        PresidentCell(president: PresidentViewModel.default)
            .previewLayout(.sizeThatFits)
    }
}
