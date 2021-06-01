//
//  Models.swift
//  TodoList-iOS
//
//  Created by Decagon on 22/05/2021.
//
import RealmSwift
import Foundation

@objcMembers class ListItems: Object {
    dynamic var titleOfTodo: String = ""
    dynamic var descriptionOfTodo: String = ""
    dynamic var dateOfTodo: Date = Date()
}
