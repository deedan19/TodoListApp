//
//  TodoTableViewCell.swift
//  TodoList-iOS
//
//  Created by Decagon on 22/05/2021.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var todoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func  configure (with models: ListItems) {
        titleLabel.text = models.titleOfTodo.capitalized
        titleLabel.font = UIFont(name: Constant.boldFont, size: 20)
        descrLabel.text = models.descriptionOfTodo
        descrLabel.font = UIFont(name: Constant.font, size: 20)
        let date = models.dateOfTodo
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm a"
        todoDate.text = formatter.string(from: date)
  
    }
    
}
