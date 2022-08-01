//
//  DatabaseManager.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //added public api, function for app to use, all codes related to the databse is in this class.
    
    //functions that auth manager uses
    
    ///check if username and email is available
    ///-Parameters
    ///-email: String representing email
    ///-username: String representing username
    ///-completion: Async callback for result if database entry succeeded
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void){
      completion(true)
    }
    
    
    ///insert new user data to database
    ///-Parameters
    ///-email: String representing email
    ///-username: String representing username
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        //no need to save the password to database?
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                //succeeded
             completion(true)
             return
            }
            else {
                //failed
            completion(false)
            return
            }
        }
    }
    
    

    
   
    
}
