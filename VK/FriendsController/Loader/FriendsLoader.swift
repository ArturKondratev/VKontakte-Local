//
//  FriendsLoader.swift
//  VK
//
//  Created by Артур Кондратьев on 26.02.2022.
//

class FriendsLoader {
    
    static var friends: [FriendModel] = [
        FriendModel(name: "Mark Zuckerberg",
                    image: "Mark_Z",
                    storedImages: ["1"]),
        FriendModel(name: "Bill Gates",
                    image: "Bill_Gates",
                    storedImages: ["1", "2"]),
        FriendModel(name: "Elon Musk",
                    image: "Ilon_Mask",
                    storedImages: ["1", "2", "3"]),
        FriendModel(name: "Pavel Dyrov",
                    image: "Pavel_Dyrov",
                    storedImages: ["1", "2", "3", "4"]),
        FriendModel(name: "Jack Ma",
                    image: "Jack_Ma",
                    storedImages: ["1", "2", "3", "4", "5"]),
        FriendModel(name: "Tim Cook",
                    image: "Tim_Cook",
                    storedImages: ["1", "2", "3", "4", "5"])
    ]
    
    static func iNeedFriends() -> [FriendsSection] {
        let sortedArray = sortFriends(array: friends)
        let sectionsArray = formFriendsSection(array: sortedArray)
        return sectionsArray
    }
    
    
    static func sortFriends(array: [FriendModel]) -> [Character: [FriendModel]] {
        var newArray: [Character: [FriendModel]] = [:]
        for friend in array {
            guard let firstChar = friend.name.first else {
                continue
            }
            
            guard var array = newArray[firstChar] else {
                let newValue = [friend]
                newArray.updateValue(newValue, forKey: firstChar)
                continue
            }
            
            array.append(friend)
            newArray.updateValue(array, forKey: firstChar)
        }
        return newArray
    }
    
    static func formFriendsSection(array: [Character: [FriendModel]]) -> [FriendsSection] {
        var sectionsArray: [FriendsSection] = []
        for (key, array) in array {
            sectionsArray.append(FriendsSection(key: key, data: array))
        }
        sectionsArray.sort { $0 < $1 }
        
        return sectionsArray
    }
}

