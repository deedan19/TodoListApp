//
//  RealmService.swift
//  TodoList-iOS
//
//  Created by Decagon on 25/05/2021.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    // Create
    func create <T: Object> (_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    // Update
    func update (_ object: ListItems, with title: String, with description: String, with date: Date ) {
        do {
            try realm.write {
                object.titleOfTodo = title
                object.descriptionOfTodo = description
                object.dateOfTodo = date
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    // Delete
    func delete <T: Object> (_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
}
