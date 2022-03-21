//
//  CurrentFriendController.swift
//  VK
//
//  Created by Артур Кондратьев on 11.02.2022.
//

import UIKit

class CurrentFriendController: UICollectionViewController {
    
    var friend: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as?
                CurrentFriendCell else { return UICollectionViewCell() }
        
        let photo = friend[indexPath.row]
        
        cell.friendImage.image = photo
        
        return cell
    }
    
    // MARK: - segue
    // переход на контроллер с отображением крупной фотографии
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let photosFriend = segue.destination as? FriendsPhotosViewController else { return }
            // индекс нажатой ячейки
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                photosFriend.allPhotos = friend //фотки
                photosFriend.countCurentPhoto = indexPath.row // indexPath[0][1] если не использовать ?.first выше
            }
        }
    }
}
