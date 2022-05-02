//
//  AthletePresenter.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import Foundation

protocol AthletePresenterProtocol {
    var router: AthleteRouterDelegate? {get set}
    var interactor: AthleteInteractorProtocol? {get set}
    var view: MyAthletesViewControllerProtocol? { get set }
    
    func interactorDidFetchBlayzeUser(with result: Result<[Athlete], Error>)
    func interactorDidFetchRecuitUser(with result: Result<[Athlete], Error>)
}

class AthletePresenter: AthletePresenterProtocol {
    
    var router: AthleteRouterDelegate?
    
    var interactor: AthleteInteractorProtocol? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: MyAthletesViewControllerProtocol?
    
    func interactorDidFetchBlayzeUser(with result: Result<[Athlete], Error>) {
        switch result {
        case .success(let users):
            view?.update(blayzeAthlete: users)
        case .failure(_):
            view?.update(with: "Something went wrong")
        }
    }
    
    func interactorDidFetchRecuitUser(with result: Result<[Athlete], Error>) {
        switch result {
        case .success(let users):
            view?.update(recuitAthlete: users)
        case .failure(_):
            view?.update(with: "Something went wrong")
        }
    }
}
