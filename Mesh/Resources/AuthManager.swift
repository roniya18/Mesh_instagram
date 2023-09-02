//
//  AuthManager.swift
//  Mesh
//
//  Created by alkesh s on 31/08/23.
//

import Foundation
import FirebaseAuth

public class AuthManager{
    
    static let shared = AuthManager()
    
    public func Register(userName:String,email:String,password:String,completion : @escaping (Bool)-> Void){
        
        DatabaseManager.shared.canCreateNewUser(with: email, userName: userName) { canCreate in
            if canCreate{
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil , result != nil else {
                        completion(false)
                        return
                    }
                    //insert to database
                    DatabaseManager.shared.insertNewUser(email: email, userName: userName){ inserted in
                        if inserted{
                            completion(true)
                            return
                        }
                        else{
                            completion(false)
                            return
                        }
                    }
                }
            }
            else{
                completion(false)
            }
            
        }
    }
    
    public func Login(userName:String?,email:String?,password:String,completion: @escaping (Bool) -> Void){
        //EMAIL LOGIN
        if let email = email{
            Auth.auth().signIn(withEmail:email, password: password) { authData, error in
                guard authData != nil,error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        
        //USERNAME LOGIN
        else if let userName = userName{
            print(userName )
        }
    }
    
    public func logOut(completion:(Bool)->Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch  {
            print(error)
            completion(false)
            return
        }
    }
}
