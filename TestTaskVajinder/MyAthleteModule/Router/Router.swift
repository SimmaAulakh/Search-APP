//
//  Router.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import UIKit

typealias EntryPoint = UINavigationController

protocol AthleteRouterDelegate {
    var entryPoint: EntryPoint? { get }
    static func start() -> AthleteRouterDelegate
}

class AthleteRouter: AthleteRouterDelegate {
    
    var entryPoint: EntryPoint?
    
    static func start() -> AthleteRouterDelegate {
        let router = AthleteRouter()
        
        //asign VIP
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.Identiefiers.myAthleteController) as? MyAthletesViewController
        let nav = storyBoard.instantiateViewController(withIdentifier: Constants.Identiefiers.navigationController) as? UINavigationController
        nav?.viewControllers = [vc!]
        var view: MyAthletesViewControllerProtocol = vc!
        
        var interactor: AthleteInteractorProtocol = AthleteInteractor()
        var presenter: AthletePresenterProtocol = AthletePresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entryPoint = nav
        return router
    }
}
