//
//  MyAthletesViewController.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import UIKit

protocol MyAthletesViewControllerProtocol {
    var presenter: AthletePresenterProtocol? { get set }
    func update(blayzeAthlete: [Athlete])
    func update(recuitAthlete: [Athlete])
    func update(with error: String)
}

class MyAthletesViewController: UIViewController, MyAthletesViewControllerProtocol{
    
    //MARK: - IBOutlets
    @IBOutlet weak var athletesTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //MARK: - Variables
    var presenter: AthletePresenterProtocol?
    private var searchController: UISearchController!
    private var athleteType: AthleteType = .Blayze
    private var blayzeAthletes: [Athlete] = []
    private var recuitAthletes: [Athlete] = []
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerNibs()
    }
    
    private func registerNibs() {
        athletesTableView.register(UINib(nibName: Constants.Identiefiers.blayzeAthleteCell, bundle: nil), forCellReuseIdentifier: Constants.Identiefiers.blayzeAthleteCell)
    }
    
    // MARK: - Helper Functions
    private func configureUI() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Message Search"
        showSearchBarButton(shouldShow: true)
        
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Identiefiers.searchAthleteViewController)
        searchController = UISearchController(searchResultsController: searchVC)
        searchController.searchBar.barStyle = .default
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchController.searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = nil
        navigationItem.searchController = shouldShow ? searchController : nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self!.searchController.searchBar.becomeFirstResponder()
            self!.searchController.showsSearchResultsController = true
        }
    }
    
    func update(blayzeAthlete: [Athlete]) {
        self.blayzeAthletes = blayzeAthlete
    }
    
    func update(recuitAthlete: [Athlete]) {
        self.recuitAthletes = recuitAthlete
    }
    
    func update(with error: String) { }
    
    //MARK: IBActions
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
    }
    
    @IBAction func segmentDidTapped(_ sender: UISegmentedControl) {
        athleteType = (sender.selectedSegmentIndex == 0) ? .Blayze : .Recruits
        athletesTableView.reloadData()
    }
}

extension MyAthletesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athleteType == .Blayze ? self.blayzeAthletes.count : self.recuitAthletes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identiefiers.blayzeAthleteCell, for: indexPath) as? BlayzeAthleteCell
        cell?.athleteType = athleteType
        cell?.setData = athleteType == .Blayze ? self.blayzeAthletes[indexPath.row] : self.recuitAthletes[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return athleteType == .Blayze ? 100 : 80
    }
}

extension MyAthletesViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let athletes = athleteType == .Blayze ? blayzeAthletes : recuitAthletes
        let filteredResults = athletes.filter { athlete in
            return athlete.name.contains( searchText)
        }
        
        if let searchVC = searchController.searchResultsController as? SearchAthleteViewController{
            searchVC.athleteType = athleteType
            searchVC.searchedString = searchText
            searchVC.filteredResults = filteredResults
        }
    }
}

extension MyAthletesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
}



