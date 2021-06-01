//
//  ViewController.swift
//  TodoList-iOS
//
//  Created by Decagon on 21/05/2021.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet var table: UITableView!
    
    // MARK: - PROPERTIES
    let realm = try! Realm()
    private var models = [ListItems]()
    public var updateHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        table.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
    }
    
    // MARK: - Create New Todo
    func showCreatedTodo (with title: String, _ description: String, _ date: Date) {
        let newTodoItem = ListItems()
        newTodoItem.titleOfTodo = title
        newTodoItem.descriptionOfTodo = description
        newTodoItem.dateOfTodo = Date()
        self.models.append(newTodoItem)
        self.refresh()
    }
    
   // MARK: - Add Button Tapped
    @IBAction func didTapAddButtion () {
        guard let createTodoVC = (storyboard?.instantiateViewController(identifier: Constant.createTodoVC))  as? CreateNewTodoViewController else { return }
        createTodoVC.completion = { title, description, date in
            self.navigationController?.popViewController(animated: true)
            self.showCreatedTodo(with: title, description, date)
        }
        
        createTodoVC.title = "Enter New Item"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(createTodoVC, animated: true)
    }
    
    func refresh() {
        models = realm.objects(ListItems.self).map({ $0 })        
        table.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as? TodoTableViewCell
        cell?.configure(with: models[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        guard let todoDetailsVC = storyboard?.instantiateViewController(identifier: Constant.todoDetailsVC) as? TodoDetailsViewController else { return }
        
        todoDetailsVC.item = item
        todoDetailsVC.title = "Details"
        todoDetailsVC.navigationItem.largeTitleDisplayMode = .never
        todoDetailsVC.deletionHandler = {[weak self] in
            self?.refresh()
        }
        todoDetailsVC.updateHandler = {
            self.refresh()
        }
        navigationController?.pushViewController(todoDetailsVC, animated: true )
    }
}
