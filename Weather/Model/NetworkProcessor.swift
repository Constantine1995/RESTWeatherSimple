//
//  NetworkProcessor.swift
//  Weather
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class NetworkProcessor {
    
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    // Using URLSession for downloading content
    lazy var session: URLSession = URLSession(configuration: configuration)
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String : Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler) {
        
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let hhtpResopnse = response as? HTTPURLResponse {
                    switch hhtpResopnse.statusCode {
                    case 200:
                        do {
                            if let data = data {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion((jsonDictionary as! [String : Any]))
                            }
                        }
                        catch  let error as NSError {
                            print("Error processing json data: \(error.localizedDescription)")
                        }
                        
                    default: print("HTTp response Code: \(hhtpResopnse.statusCode)")
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription ?? #"Not Found"#)")
            }
        }
        dataTask.resume()
    }
}
