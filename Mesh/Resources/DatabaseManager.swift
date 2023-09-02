//
//  DatabaseManager.swift
//  Mesh
//
//  Created by alkesh s on 31/08/23.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager{
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    public func canCreateNewUser(with email:String,userName : String,completion : (Bool)-> Void){
        completion(true)
    }

    public func insertNewUser(email:String,userName:String,completion:@escaping(Bool)->Void){
        database.child(email.safeKey()).setValue(["username":userName]) { error, _ in
            if error == nil{
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
