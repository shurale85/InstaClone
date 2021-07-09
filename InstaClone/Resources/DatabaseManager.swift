//
//  DatabaseManager.swift
//  InstaClone
//
//  Created by NewUSER on 04.07.2021.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database =
        Database.database(url: "https://instaclone-be8a7-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    // MARK: - Public

    /// Check if username and email is available
    /// - Paramters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        
        // Check if username is avaialble
        completion(true)
        
    }
    
    /// Insert new user into DB
    /// - Paramters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry ssucceeded
    public func insertNewUser(with email: String, username: String, completeion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                completeion(true)
                return
            }
            else {
                completeion(false)
                return
            }
            
        }
        
    }
    
    // MARK: -Private
}
