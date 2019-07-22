//
//  ShowDetailsTableViewController.swift
//  VFChallengeTPV
//
//  Created by Teresa on 17/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import UIKit

class ShowDetailsTableViewController: UITableViewController {

    var repository: Repository?
    
    @IBOutlet weak var numStarsLabel: UILabel!
    @IBOutlet weak var numCommitsLabel: UILabel!
    @IBOutlet weak var numForksLabel: UILabel!
    @IBOutlet weak var numBranchLabel: UILabel!
    
    var repositoryController =  RepositoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let repository = repository {
            numStarsLabel.text = String(repository.numberStars)
            numForksLabel.text = String(repository.numberForks)
            searchCommits(repository: repository)
            searchBranches(repository: repository)
        }
    }
    
    func searchCommits(repository: Repository) -> Void {
        repositoryController.getNumberOfLastPage(repository: repository.name, nameAuthor: repository.author, typePath: .commits) { lastPage in
            DispatchQueue.main.async {
                self.numCommitsLabel.text = String(lastPage)
            }
        }
    }
    
    func searchBranches(repository: Repository) -> Void {
        self.repositoryController.getNumberOfLastPage(repository: repository.name, nameAuthor: repository.author, typePath: .branch) { lastPage in
            DispatchQueue.main.async {
                self.numBranchLabel.text = String(lastPage)
            }
        }
    }
}
