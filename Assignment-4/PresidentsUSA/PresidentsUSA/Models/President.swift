//
//  President.swift
//  PresidentsUSA
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

//  the keys, coding keys are also defined here and number formating too. 

import Foundation


struct President: Decodable {
    
    var name: String
    var number: Int
    var startDate: String
    var endDate: String
    var nickname: String
    var politicalParty: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case number = "Number"
        case startDate = "Start Date"
        case endDate = "End Date"
        case nickname = "Nickname"
        case politicalParty = "Political Party"
    }
    
    var ordinalNumber: String {
            let suffix: String
            switch number % 10 {
            case 1:
                suffix = number % 100 == 11 ? "th" : "st"
            case 2:
                suffix = number % 100 == 12 ? "th" : "nd"
            case 3:
                suffix = number % 100 == 13 ? "th" : "rd"
            default:
                suffix = "th"
            }
            return "\(number)\(suffix)"
        }
}

