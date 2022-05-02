//
//  SearchAthleteViewController.swift
//  TestTaskVajinder
//
//  Created by Simranjeet Aulakh on 04/02/22.
//

import UIKit

class SearchAthleteViewController: UIViewController {
    
    //MARK: - IOutlets
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!asasas
    
    //MARK: - Variables
    var athleteType: AthleteType? = .Blayze
    var searchedString: String?
    var filteredResults: [Athlete] = [] {
        didSet{
            self.searchTable.reloadData()
            titleLabel.text = (searchedString != nil && filteredResults.count >= 1) ? "Recent" : "Results"
        }
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredResults = DummyData.shared.recentSearches
        
    }
    
    //MARK: - User defined functions
    private func registerNibs() {
        searchTable.register(UINib(nibName: Constants.Identiefiers.blayzeAthleteCell, bundle: nil), forCellReuseIdentifier: Constants.Identiefiers.blayzeAthleteCell)
    }
}

extension SearchAthleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identiefiers.blayzeAthleteCell, for: indexPath) as? BlayzeAthleteCell
        cell?.athleteType = athleteType
        cell?.searchedText = searchedString
        cell?.setData = self.filteredResults[indexPath.row]
        cell?.deleteButton.tag = indexPath.row
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedAthelete = filteredResults[indexPath.row]
        selectedAthelete.isRecentSearch = true
        if !DummyData.shared.recentSearches.contains(where: { $0.name == filteredResults[indexPath.row].name} ){
        DummyData.shared.recentSearches.append(selectedAthelete)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return athleteType == .Blayze ? 100 : 80
    }
}

extension SearchAthleteViewController: BlayzeAthleteCellDelegate {
    func deleteRecentSearchHistory(_ index: Int) {
        DummyData.shared.recentSearches.remove(at: index)
        filteredResults = DummyData.shared.recentSearches
        searchTable.reloadData()
    }
}
