//
//  AuthManager.swift
//  Navigation
//
//  Created by Kiryl Rakk on 28/3/23.
//
import FirebaseAuth
import Foundation

class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    static let number = "9669666666"
    static let smsCode = "666666"
    
    private var verificationID: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
                guard let verificationID = verificationID, error == nil  else {
                    completion(false)
                    print(error?.localizedDescription)
                    return
                }
                self?.verificationID = verificationID
                completion(true)
            }
    }
    
    public func verifySMS(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationID = verificationID else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard  result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
