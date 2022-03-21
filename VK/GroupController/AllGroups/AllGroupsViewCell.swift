//
//  AllGroupsViewCell.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

class AllGroupsViewCell: UITableViewCell {

    @IBOutlet weak var groupsName: UILabel!
    @IBOutlet weak var groupsIcon: CustomView!
    
    func cofigur (name: String, icon: UIImage) {
        groupsName.text = name
        groupsIcon.image = icon
    }
    
}
