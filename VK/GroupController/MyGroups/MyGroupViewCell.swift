//
//  MyGroupViewCell.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

class MyGroupViewCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupIcon: CustomView!
    
    func configre(name: String, icon: UIImage) {
        groupName.text = name
        groupIcon.image = icon
    }
    
}
