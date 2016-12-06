//
//  APIRequestManager.swift
//  GameOfThrones2
//
//  Created by Ana Ma on 12/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager {
    static let shared: APIRequestManager = APIRequestManager()
    private init () {}

    internal func getData(endpoint: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: endpoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print(error)
            }
            guard let validData = data else { return }
            completion(validData)
        }.resume()
    }
}
