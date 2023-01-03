//
//  User.swift
//  Navigation
//
//  Created by Krime Loma on 26/9/22.
//

import UIKit
import KeychainAccess
import RealmSwift


class UserLogin: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var login: String = ""
    @Persisted var password: String = ""
}

class ServiceLogIn  {

    func saveLogIngData(login: String, password: String) {
        let userLogin = UserLogin()
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
       
        // Configure for an encrypted realm
        let config = Realm.Configuration(encryptionKey: getKey())

        do {
            // Open the encrypted realm
            let realm = try Realm(configuration: config)
            userLogin.login = login
            userLogin.password = password
            try! realm.write {
                realm.add(userLogin)
            }
            
        } catch let error as NSError {
            fatalError("Error opening realm: \(error.localizedDescription)")
        }

    }
        
        
        func getKey() -> Data {
            // Identifier for our keychain entry - should be unique for your application
            let keychainIdentifier = "io.Realm.EncryptionExampleKey"
            let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            // First check in the keychain for an existing key
            var query: [NSString: AnyObject] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecReturnData: true as AnyObject
            ]
            // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
            // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
            var dataTypeRef: AnyObject?
            var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
            if status == errSecSuccess {
                // swiftlint:disable:next force_cast
                return dataTypeRef as! Data
            }
            // No pre-existing key from this application, so generate a new one
            // Generate a random encryption key
            var key = Data(count: 64)
            key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
                let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
                assert(result == 0, "Failed to get random bytes")
            })
            // Store the key in the keychain
            query = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecValueData: key as AnyObject
            ]
            status = SecItemAdd(query as CFDictionary, nil)
            assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
            return key
        }
}

class User {
    var login : String
    var fullName: String
    var image: UIImage
    var status: String
    
    init(login: String, fullName: String, image: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.image = image
        self.status = status
    }
}
