//
//  NetworkService.swift
//  Navigation
//
//  Created by Kiryl Rakk on 3/11/22.
//

import UIKit

//[
//  {
//    "userId": 1,
//    "id": 1,
//    "title": "delectus aut autem",
//    "completed": false
//  },
//  {
//    "userId": 1,
//    "id": 2,
//    "title": "quis ut nam facilis et officia qui",
//    "completed": false
//  },



enum NetworkConfiguration: String {
    case urlOne = "https://jsonplaceholder.typicode.com/todos/"
    case urlTwo = "https://swapi.dev/api/planets/1"
}

enum MyError: Error {
    case dataError
    case responseError
    case simpleError
    case statusCodeError
    case headerError
}

struct Answer: Decodable {
    var userId: String
    var id: String
    var title: String
    var completed: String
    
}

func requestOne(for urlString: String, completion: ((_ requestString: String?)->())? ) {
        
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task  = session.dataTask(with: url) { data, responce, error in
            
            if let error {
                print("Error: \(error.localizedDescription)")
                completion?(nil)
            }
            
            
            if (responce as? HTTPURLResponse)?.statusCode  != 200 {
                print(MyError.responseError)
                completion?(nil)

            }
            
            guard let data else  {
                print(MyError.dataError)
                completion?(nil)
                return
            }
            
            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [[String:Any]] {
                    
                    if let answerLabel = answer.first {
                        completion?(answerLabel["title"] as? String)
                    }
                }
            }
            
            
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }



