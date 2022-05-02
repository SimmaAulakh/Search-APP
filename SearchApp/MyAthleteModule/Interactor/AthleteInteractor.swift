//
//  AthleteInteractor.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import Foundation

protocol AthleteInteractorProtocol {
    var presenter: AthletePresenterProtocol? { get set }
    func getUsers()
}

class AthleteInteractor: AthleteInteractorProtocol {
    var presenter: AthletePresenterProtocol?
    
    func getUsers() {
        let blayzeAthletes = DummyData.shared.blayzeAthletes
        let recuitAthletes = DummyData.shared.recruits
        
        presenter?.interactorDidFetchBlayzeUser(with: .success(blayzeAthletes))
        presenter?.interactorDidFetchRecuitUser(with: .success(recuitAthletes))
    }
}
