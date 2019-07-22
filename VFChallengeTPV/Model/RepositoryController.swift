//
//  RepositoryController.swift
//  VFChallengeTPV
//
//  Created by Teresa on 18/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import Foundation

struct RepositoryController {
    
    private let apiClient: API
    
    init(apiClient: API = APIClient()) {
        self.apiClient = apiClient
    }
    
    /**
     Get all public repositories
     
     - parameter author:      The location used to calculate the nearest cities
     - parameter page:        Number of the page which gets the repositories
     */
    func fechRepositories(matching author: String, page: Int, completion: @escaping ([Repository]?) -> Void) {
        let repositoryRequest = FetchRepositoriesRequest(author: author, page: page)
        apiClient.send(repositoryRequest) { repositories in
            completion(repositories)
        }
    }
    
    /**
     Get the number for the last page, for the commits and branches,
     only takes one of them per page, so the number of commits and branches is the same that number of pages
     
     - parameter Repository:      repository's name where gets the numbers of commits
     - parameter nameAuthor:      author's name where gets the numbers of commits
     - parameter typePath:        type of query
     - returns: the number of the last page
     */
    func getNumberOfLastPage(repository: String, nameAuthor: String, typePath: TypePath, completion: @escaping (_ result: Int) -> ()) {
        let path: String
        let range: String
        switch typePath {
        case .repository:
            path = "/users/" + repository + "/repos?"
            range = "page="
        case .branch:
            path = "/repos/" + nameAuthor + "/" +  repository + "/branches?per_page=1"
            range = "&page="
        case .commits:
            path = "/repos/" + nameAuthor + "/" +  repository + "/commits?per_page=1"
            range = "&page="
        }
        
        guard let url = URL(string: (baseURL + path)) else {
            completion(0)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse,
                let stringLinks: String = httpResponse.allHeaderFields["Link"] as? String {
                
                let links = stringLinks.components(separatedBy: ",")
                var dictionary: [String: String] = [:]
                
                links.forEach({
                    let components = $0.components(separatedBy:"; ")
                    let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
                    dictionary[components[1]] = cleanPath
                })
                
                let substring = getLastPartSubstring(with: dictionary["rel=\"last\""]!, range: range)
                completion(Int(substring) ?? 0)
            } else {
                completion(1)
            }
        }
        task.resume()
    }
}
