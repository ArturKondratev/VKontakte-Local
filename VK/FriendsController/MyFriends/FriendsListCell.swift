//
//  FriendsListCell.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendIcon: CustomView!
    
    func configure (model: FriendModel) {
        friendName.text = model.name
        guard let image = UIImage(named: model.image) else { return }
        friendIcon.image = image
    }
}
