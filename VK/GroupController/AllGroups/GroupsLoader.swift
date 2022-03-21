//
//  GroupsLoader.swift
//  VK
//
//  Created by Артур Кондратьев on 15.03.2022.
//
class GroupsLoader {
    
    static func needGroups() -> [GroupModel] {
        
        return [GroupModel(name: "IOS Developer", icon: "g1"),
                GroupModel(name: "Swift Book", icon: "g2"),
                GroupModel(name: "Geek Brains", icon: "g3"),
                GroupModel(name: "Coral Travel", icon: "g4"),
                GroupModel(name: "MARVEL/DC", icon: "g5"),
                GroupModel(name: "NETFLIX", icon: "g6")
        ]
    }
}
