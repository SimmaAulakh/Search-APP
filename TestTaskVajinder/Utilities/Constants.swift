//
//  Constants.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import UIKit

enum AthleteType {
    case Blayze, Recruits
}

enum MessagePriority {
    case high, medium, low
}

struct Constants {
    
    struct Identiefiers {
        static let blayzeAthleteCell = "BlayzeAthleteCell"
        static let searchAthleteViewController = "SearchAthleteViewController"
        static let myAthleteController = "MyAthletesViewController"
        static let navigationController = "athleteNav"
    }
    
    struct AppColors {
        static let appGrayColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1.0)
    }
}
