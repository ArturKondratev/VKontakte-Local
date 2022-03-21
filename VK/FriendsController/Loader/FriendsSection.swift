//
//  FriendsSection.swift
//  VK
//
//  Created by Артур Кондратьев on 26.02.2022.
//

struct FriendsSection: Comparable {

    var key: Character
    var data: [FriendModel]

    static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key < rhs.key
    }

    static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
        return lhs.key == rhs.key
    }
}

