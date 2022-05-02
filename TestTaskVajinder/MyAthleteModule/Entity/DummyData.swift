//
//  DummyData.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import Foundation

struct Athlete {
    var name: String
    var position: String
    var time: String?
    var type: AthleteType
    var image: String
    var isRecentSearch: Bool? = false
    var messagePriority: MessagePriority? = .low
}


class DummyData {
    
    static let shared = DummyData()
    
    var blayzeAthletes:[Athlete] = [
        Athlete(name: "Ashley Daniels", position: "Midfielder", time: "Last messaged 1 week ago", type: .Blayze, image: "user1", messagePriority: .high),
        Athlete(name: "Drew Parker", position: "Forward", time: "Last messaged 3 days ago", type: .Blayze, image: "user2", messagePriority: .medium),
        Athlete(name: "Ana Maybel", position: "Forward", time: "Last messaged today", type: .Blayze, image: "user3"),
        Athlete(name: "Stephen Williams", position: "Forward", time: "Last messaged Yesterday", type: .Blayze, image: "user4"),
        Athlete(name: "Brian Delbert", position: "Midfielder", time: "Last messaged yesterday", type: .Blayze, image: "user5"),
    ]
    
    var recruits: [Athlete] = [
        Athlete(name: "Lisa Delbert", position: "Defender", type: .Recruits, image: "user6"),
        Athlete(name: "Ricky Faris", position: "Defender", type: .Recruits, image: "user7"),
        Athlete(name: "Monica Lopez", position: "Forward", type: .Recruits, image: "user8"),
        Athlete(name: "Blake Mesa", position: "Midfielder", type: .Recruits, image: "user9"),
    ]
    
    /// all the recent searches that user searched.
    var recentSearches: [Athlete] = []
}

