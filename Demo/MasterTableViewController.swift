//
//  MasterTableViewController.swift
//  Demo
//
//  Created by Đừng xóa on 8/24/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    var filtered = [PlacesVietNam]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder =
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All", "Miền Bắc", "Miền Trung", "Miền Nam", "Miền Tây"]
        searchController.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filtered.count
        }
        return DataService.shared.my4mien.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let place: PlacesVietNam
        if isFiltering() {
            place = filtered[indexPath.row]
        } else {
            place = DataService.shared.my4mien[indexPath.row]
        }
        
        cell.textLabel?.text = place.name
        return cell
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filtered = DataService.shared.my4mien.filter({ (place: PlacesVietNam) -> Bool in
            let doesCategoryMatch = (scope == "All") || (place.place == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && place.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? DetailViewController
        let pickedPlace: PlacesVietNam
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if isFiltering() {
                pickedPlace = filtered[indexPath.row]
            } else {
                pickedPlace = DataService.shared.my4mien[indexPath.row]
            }
            detailViewController?.place = pickedPlace
        }
    }
 

}

extension MasterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
}

extension MasterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
