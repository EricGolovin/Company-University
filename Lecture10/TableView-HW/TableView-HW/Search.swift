//
//  Search.swift
//  TableView-HW
//
//  Created by Eric Golovin on 6/25/20.
//

import Foundation

class Search {
    typealias SearchComplete = (Bool) -> Void
    
    var itemSearchCount = "10"
    private var dataTask: URLSessionDataTask?
    private(set) var results = Array<SearchResult>()
    
    
    func performSearch(for text: String, completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
            
            let url = iTunesURL(searchText: text)
            
            let session = URLSession.shared
            dataTask = session.dataTask(with: url) { data, response, error in
                var success = false
                // Was the search cancelled?
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    let searchResults = self.parse(data: data)
                    self.results = searchResults
                    success = true
                    print("Success!")
                }
                DispatchQueue.main.async {
                    completion(success)
                }
            }
            dataTask?.resume()
        }
    }
    
    func deleteResult(at indexPath: IndexPath) {
        results.remove(at: indexPath.row)
    }
    
    private func iTunesURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://itunes.apple.com/search?term=\(encodedText)&limit=" + itemSearchCount
        let url = URL(string: urlString)
        
        return url!
    }
    
    private func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
}
