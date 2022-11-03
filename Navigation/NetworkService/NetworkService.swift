//
//  NetworkService.swift
//  Navigation
//
//  Created by Kiryl Rakk on 3/11/22.
//

import UIKit


enum AppConfiguration: String {
    case one = "https://swapi.dev/api/people/8"
    case two = "https://swapi.dev/api/starships/3"
    case three = "https://swapi.dev/api/planets/5"
}

enum MyError: Error {
    case dataError
    case responseError
    case simpleError
    case statusCodeError
    case headerError
}


struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        
        let urlString = configuration.rawValue
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task  = session.dataTask(with: url) { data, responce, error in
            
            if let error {
                print("Error: \(error.localizedDescription)")
            }
            

            guard let responce = (responce as? HTTPURLResponse) else {
                print(MyError.responseError)
                return }
            let header = responce.allHeaderFields
            let statusCode = responce.statusCode
            print("-----StatusCode : \(statusCode)")
            print("-----Header is : \(String(describing: header["Etag"])) \n \n \n")

            guard let data else  {
                print(MyError.dataError)
                return
            }
            
            
            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any], let name = answer["name"] as? String {
                    print ("name:  \(name)")
                    print(answer)
                }
            }
            
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}


extension AppConfiguration: CaseIterable {
    
}
