//
//  Order.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//

import Foundation
import FirebaseDatabase

// Modern Swift model with Codable support
struct Order: Codable {
    var name: String
    var room: String
    var type: OrderType
    var flavor: String
    var specialRequest: String?
    
    // Coffee-specific properties
    var creamer: String?
    var milk: String?
    var temp: String?
    
    enum OrderType: String, Codable {
        case coffee
        case tea
    }
    
    // Convert from Firebase snapshot
    static func from(snapshot: DataSnapshot) -> Order? {
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        
        let name = dict["name"] as? String ?? ""
        let room = dict["room"] as? String ?? ""
        let typeString = dict["type"] as? String ?? "coffee"
        let type = OrderType(rawValue: typeString) ?? .coffee
        let flavor = dict["flavor"] as? String ?? ""
        let specialRequest = dict["special request"] as? String
        
        var order = Order(
            name: name,
            room: room,
            type: type,
            flavor: flavor,
            specialRequest: specialRequest
        )
        
        if type == .coffee {
            order.creamer = dict["creamer"] as? String
            order.milk = dict["milk"] as? String
            order.temp = dict["temp"] as? String
        }
        
        return order
    }
    
    // Convert to dictionary for Firebase
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "name": name,
            "room": room,
            "type": type.rawValue,
            "flavor": flavor
        ]
        
        if let specialRequest = specialRequest {
            dict["special request"] = specialRequest
        }
        
        if type == .coffee {
            if let creamer = creamer {
                dict["creamer"] = creamer
            }
            if let milk = milk {
                dict["milk"] = milk
            }
            if let temp = temp {
                dict["temp"] = temp
            }
        }
        
        return dict
    }
}
