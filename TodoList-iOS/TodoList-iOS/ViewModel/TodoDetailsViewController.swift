//
//  TodoDetailsViewController.swift
//  TodoList-iOS
//
//  Created by Decagon on 22/05/2021.
//

import UIKit
import RealmSwift

class TodoDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let realm = try! Realm()
    public var item: ListItems?
    public var deletionHandler: (() -> Void)?
    public var updateHandler: (() -> Void)?
    
    // MARK: - OUTLETS
    @IBOutlet weak var detailView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    
    // MARK: - SETUP VIEWS
    fileprivate func viewDetails () {
        detailView.layer.cornerRadius = 10
        titleTextField.textColor = .white
        titleTextField.font = UIFont(name: Constant.boldFont, size: 20)
        titleTextField.text = item?.titleOfTodo.capitalized
        titleTextField.backgroundColor = .clear
        titleTextField.layer.borderWidth = 0
        
        descriptionTextView.textColor = .white
        descriptionTextView.font = UIFont(name: Constant.font, size: 20)
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.text = item?.descriptionOfTodo
        descriptionTextView.backgroundColor = .clear
        fillTextFields()
    }
    
    func fillTextFields () {
        titleTextField.text = item?.titleOfTodo.capitalized
        descriptionTextView.text = item?.descriptionOfTodo
    }
    
    @objc func updateTodo() {
        RealmService.shared.update(item!, with: titleTextField.text!, with: descriptionTextView.text!, with: Date())
        updateHandler?()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDetails()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(updateTodo))
    }
    
    @IBAction func editTodo (_ sender: UIButton) {
        titleTextField.isUserInteractionEnabled = true
        descriptionTextView.isUserInteractionEnabled = true
        self.title = "Edit this To do"
    }
    
    @IBAction func deleteTodo (_ sender: UIButton) {
        guard let myItem = self.item else { return }
        RealmService.shared.delete(myItem)
        deletionHandler?()
        navigationController?.popViewController(animated: true)
    }
}
