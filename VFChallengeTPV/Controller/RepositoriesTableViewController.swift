//
//  RepositoriesTableViewController.swift
//  VFChallengeTPV
//
//  Created by Teresa on 17/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var repositoryController = RepositoryController()
    var numerOfLastPage = 0
    var numerOfActualPage = 1
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryViewCell", for: indexPath)
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == repositories.count - 1 {
            searchRepository(page: numerOfActualPage)
        }
    }
    
    func searchRepository(page: Int){
        guard let search = searchBar.text else {
            return
        }
        
        if !search.isEmpty {
            
            if self.repositories.isEmpty {
                repositoryController.fechRepositories(matching: search, page: page) { repositories in
                    if let repositories = repositories {
                        self.repositories = repositories
                    } else {
                        print("Unable to load data.")
                    }
                }
            } else {
                
                numerOfActualPage += 1
                if numerOfActualPage <= numerOfLastPage{
                    repositoryController.fechRepositories(matching: search, page: numerOfActualPage) { repositories in
                        if let repositories = repositories {
                            self.repositories.append(contentsOf: repositories)
                        } else {
                            print("Unable to load data.")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        
        let repository = self.repositories[selectedIndexPath.row]
        let vc = segue.destination as? ShowDetailsTableViewController
        if segue.identifier == "ShowDetails" {
            vc?.repository = repository
            vc?.title = repository.name
        }
    }
}

extension RepositoriesTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        
        repositories = []
        numerOfLastPage = 0
        numerOfActualPage = 1
        searchRepository(page: numerOfActualPage)
        repositoryController.getNumberOfLastPage(repository: search, nameAuthor: "", typePath: .repository) { lastPage in
            self.numerOfLastPage = lastPage
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            repositories = []
        }
    }
}
