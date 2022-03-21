//
//  FriendsModel.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

struct FriendModel {
    let name: String
    let image: String
    let uiImage: UIImage
    var storedImages: [UIImage] = []

    init(name: String, image: String, storedImages: [String]) {
        self.name = name
        self.image = image

        uiImage = UIImage(named: image) ?? UIImage()
        
        // Собираем массив фоток юзера из имён фоток
        for storedImage in storedImages {
            guard let image = UIImage(named: storedImage) else { continue }
            self.storedImages.append(image)
        }
    }
}
