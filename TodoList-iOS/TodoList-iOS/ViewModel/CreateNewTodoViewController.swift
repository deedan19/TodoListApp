//
//  CreateNewTodoViewController.swift
//  TodoList-iOS
//
//  Created by Decagon on 22/05/2021.
//
import RealmSwift
import UIKit

// MARK: - Create a new Todo View Controller
class CreateNewTodoViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var createTodoTitle: UITextField!
    @IBOutlet weak var createTodoDescr: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Variables and Properties
    var todoUpdate: ListItems!
    public var completion: ((String, String, Date) -> Void)?
    
    // MARK: - Set up Details
    fileprivate func setupDetails () {
        createTodoDescr.layer.borderWidth = 1
        createTodoDescr.layer.cornerRadius = 10
        createTodoDescr.font = UIFont(name: Constant.font, size: 20)
        createTodoDescr.layer.borderColor = CGColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.2)
        
        createTodoTitle.becomeFirstResponder()
        createTodoTitle.font = UIFont(name: Constant.font, size: 20)
        createTodoTitle.delegate = self
        datePicker.date = Date()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    // MARK: - Save Todo
    @objc func didTapSaveButton () {
        if let title = createTodoTitle.text, !title.isEmpty,
           let description = createTodoDescr.text, !description.isEmpty {
            let date = datePicker.date
            
            let newItem = ListItems()
            newItem.titleOfTodo = title
            newItem.descriptionOfTodo = description
            newItem.dateOfTodo = date
            RealmService.shared.create(newItem)
            completion?(title, description, date)
            navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Validation Error",
                                                    message: "All fields must be filled",
                                                    preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetails()
    }
}

// MARK: - UITexfieldDelegate
extension CreateNewTodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createTodoTitle.resignFirstResponder()
        return true
    }
}
