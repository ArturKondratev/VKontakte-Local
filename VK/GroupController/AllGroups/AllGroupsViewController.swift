//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

class AllGroupsViewController: UITableViewController {
    
    weak var delegate: MyGroupsViewController?
    
    var allGroups = GroupsLoader.needGroups()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AllGroupsViewCell
        else {
            return UITableViewCell()
        }
        
        let name = allGroups[indexPath.row].name
        let avatar = allGroups[indexPath.row].icon
        
        cell.cofigur(name: name, icon: UIImage(named: avatar)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let group = allGroups[indexPath.row]
        delegate?.addGroup(group)
        navigationController?.popViewController(animated: true)
    }
}
