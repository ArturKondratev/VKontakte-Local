//
//  MyGroupsViewController.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

class MyGroupsViewController: UITableViewController {
    
    var myGroups: [GroupModel] = [
        GroupModel(name: "IOS Developer", icon: "g1")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyGroupViewCell
        else {
            return UITableViewCell()
        }
        let name = myGroups[indexPath.row].name
        let avatar = myGroups[indexPath.row].icon
        
        cell.configre(name: name, icon: UIImage(named: avatar)!)
    
        return cell
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            // Удаляем группу из массива
            myGroups.remove(at: indexPath.row)
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup" {
            let del = segue.destination as! AllGroupsViewController
            del.delegate = self
        }
    }
    
    func addGroup(_ group: GroupModel) {
        if !myGroups.contains(group) {
            myGroups.append(group)
            tableView.reloadData()
        }
    }
}
