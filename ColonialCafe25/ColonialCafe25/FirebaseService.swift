//
//  FirebaseService.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseService {
    static let shared = FirebaseService()
    
    private let database = Database.database().reference()
    private let ordersRef: DatabaseReference
    
    private init() {
        ordersRef = database.child("Orders")
    }
    
    // MARK: - Orders
    
    func fetchOrders(completion: @escaping ([String: Order]) -> Void) {
        ordersRef.observeSingleEvent(of: .value) { snapshot in
            var orders: [String: Order] = [:]
            
            for child in snapshot.children {
                guard let snapshot = child as? DataSnapshot,
                      let order = Order.from(snapshot: snapshot) else { continue }
                
                orders[snapshot.key] = order
            }
            
            completion(orders)
        }
    }
    
    func saveOrder(_ order: Order, withName name: String, room: String, completion: @escaping (Error?) -> Void) {
        let orderKey = "Order for \(name), \(room)"
        let orderData = order.toDictionary()
        
        ordersRef.child(orderKey).setValue(orderData) { error, _ in
            completion(error)
        }
    }
    
    func deleteOrder(withKey key: String, completion: @escaping (Error?) -> Void) {
        ordersRef.child(key).removeValue { error, _ in
            completion(error)
        }
    }
    
    // MARK: - Authentication
    
    func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
