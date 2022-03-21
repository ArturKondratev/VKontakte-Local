//
//  NewsViewCell.swift
//  VK
//
//  Created by Артур Кондратьев on 25.02.2022.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var imageAvatarNews: CustomView!
    @IBOutlet weak var nameUserNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!

    func configure(avatar: UIImage,
                   name: String,
                   data: String,
                   text: String,
                   image: UIImage) {
        
        imageAvatarNews.image = avatar
        nameUserNews.text = name
        dateNews.text = data
        textNews.text = text
        imageNews.image = image
    }
}
