//
//  ResidentNetworkModel.swift
//  Navigation
//
//  Created by Kiryl Rakk on 7/11/22.
//

import Foundation


func residentNetwork(for urlString: String, completion: ((_ requestString: String?)->())? ) {
    
    guard let url = URL(string: urlString) else { return }
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
        
        if let error {
            print("Error: \(error.localizedDescription)")
            completion?(nil)
        }
        
        if (response as? HTTPURLResponse)?.statusCode  != 200 {
            print(MyError.responseError)
            completion?(nil)
        }
        
        guard let data else  {
            print(MyError.dataError)
            completion?(nil)
            return
        }
        
        
        do {
            let resident = try JSONDecoder().decode(Resident.self, from: data)
           
            completion?(resident.name)

        }
        
        catch {
            print("Error Do-catch block")
        }
    }
    task.resume()
}


