//
//  PresidentViewModel.swift
//  PresidentsUSA
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

//  This is PresidentViewModel creates new president variables and returns them. Here is where the default president is defined.

import Foundation


struct PresidentViewModel {
    var president : President
    
    var name: String {
        return president.name
    }
    
    var number: Int {
        return president.number
    }
    
    var startDate: String {
        return president.startDate
    }
    
    var endDate: String {
        return president.endDate
    }
    
    var nickname: String {
        return president.nickname
    }
    
    var politicalParty : String {
        return president.politicalParty
    }
    
    var ordinalNumber : String {
        return president.ordinalNumber
    }
    
    static var `default`: PresidentViewModel {
        let president = President(name: "George Washington", number: 1, startDate: "April 30, 1789", endDate: "March 3, 1797", nickname: "\"Father of His Country\"", politicalParty: "None")
        return PresidentViewModel(president: president)
    }
}
