//
//  FirebaseDBManager.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 02/05/22.
//

import Foundation
import FirebaseDatabase

final class FirebaseDBManager {
    static let shared: FirebaseDBManager = FirebaseDBManager()
    private let databaseApi: String = "https://ola-uber-clone-bdaa4-default-rtdb.asia-southeast1.firebasedatabase.app/"
    lazy var database: Database = Database.database(url: databaseApi)
    lazy var databaseReference: DatabaseReference = database.reference()
    private init() {
        databaseReference.child("users").child("userID").child("previousDestinations").setValue([[
            "name":"Sangam Vihar",
            "postalAddress": "Ratiya Marg, Sangam Vihar, New Delhi",
            "latitude": 28.4985544,
            "longitude": 77.2227438,
        ]])
    }
    
    func getOneTimeValue<T: Decodable>(atPath path: String, type: T.Type, completionHandler: ((T?) -> Void)?) {
        databaseReference.child(path).getData { error, snapshot in
            dump("[FirebaseBDManager] error = \(error)")
            dump("[FirebaseBDManager] snapshot = \(snapshot)")
            if error == nil {
                do {
                    if let value = snapshot.value {
                        let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completionHandler?(decodedData)
                    }
                } catch {
                    completionHandler?(nil)
                }
            } else {
                completionHandler?(nil)
            }
        }
    }
}
