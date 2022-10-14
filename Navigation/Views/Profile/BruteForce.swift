//
//  BruteForce.swift
//  Navigation
//
//  Created by Kiryl Rakk on 14/10/22.
//

import UIKit

class BruteForce {
    
    
    func generatePassword (length: Int) -> String{
        var password = ""
        let passwordCharacters = Array("!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
        for _ in 0..<length {
            // generate a random index based on your array of characters count
            let rand = arc4random_uniform(UInt32(passwordCharacters.count))
            // append the random character to your string
            password.append(passwordCharacters[Int(rand)])
        }
        print("Сгеренерированный пароль -> \(password)")   // "V3VPk5LE"
        return password
    }
    
    
    func bruteForce(passwordToUnlock: String) -> String {
        print("started brute")
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            // Your stuff here
            print(password)

            // Your stuff here
        }
        
        print("Поздравляем, пароль разблокирован")
        return password
    }
}



extension String {

    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
    
        str.append(characterAt(index: 0, array))
    }
    else {
        
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    return str
}



