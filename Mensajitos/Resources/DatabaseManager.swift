//
//  DatabaseManager.swift
//  Mensajitos
//
//  Created by Aisha Belen Macedo Zeballos on 10/12/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

// MARK: - Account Mgmt

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database .child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
            
        })

    }
    
    /// Insertar nuevo usuario a base de datos
    public func insertUser(with user: ChatAppUser){
        database.child(user.safeEmail).setValue([
            "Primer nombre": user.primerNom,
            "Apellido": user.apellido
        ])
    }
}

struct ChatAppUser {
    let primerNom: String
    let apellido: String
    let email: String
    
    var safeEmail: String{
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
