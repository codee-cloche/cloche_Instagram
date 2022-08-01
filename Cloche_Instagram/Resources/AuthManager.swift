//
//  AuthManager.swift
//  Instagram
//
//  Created by grace kim  on 2022/07/27.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //added public api, function for app to use, all codes related to the databse is in this class.
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        /* check if username is available,
         check if email is available,
         create account,
         insert account to database*/

        DatabaseManager.shared.canCreateNewUser(with: email, username: username){ canCreate in
            if canCreate {
                /*
                create account,
                insert account to database*/
                Auth.auth().createUser(withEmail: email, password: password){ result, error in
                    if error == nil, result != nil {
                        //Firebase auth could not create account
                        completion(false)
                        return
                    }
                    //Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            //failed to insert into databaase
                            completion(false)
                            return
                        }
                    }                }
            }
            else {
                //either username or email does not exist
                completion(false)
                return
            }
            
        }
        
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        //optional since can login with email or username
        //completion is a result value?
        if let email = email {
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        } else if let username = username {
            //username login
            Auth.auth().signIn(withCustomToken: username) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
            
        }
        else {
            completion(false)
        }
    }
    
    public func logOut(completion: (Bool) -> Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            completion(false)
            print(error)
            return
        }
    }
}
