//
//  AuthManager.swift
//  InstaClone
//
//  Created by NewUSER on 04.07.2021.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        
        // Check if username is available
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    
                    //Inserting into DB
                    DatabaseManager.shared.insertNewUser(with: email, username: username){ inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
                return
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }
    
    /// Logout from firebase
    public func logOut(completion: (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
            
        } catch {
            print(error)
            completion(false)
            return
        }
    }
}
