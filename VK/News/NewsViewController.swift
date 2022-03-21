//
//  NewsViewController.swift
//  VK
//
//  Created by Артур Кондратьев on 25.02.2022.
//

import UIKit

class NewsViewController: UITableViewController {
    
    var news = ContentLoader.needcontent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsViewCell
        else {
            return UITableViewCell()
        }
        
        let avatar = news[indexPath.row].avatar
        let name = news[indexPath.row].nameOfNews
        let date = news[indexPath.row].dateNews
        let text = news[indexPath.row].textNews
        let image = news[indexPath.row].imageNews
        
        cell.configure(avatar: UIImage(named: avatar)!,
                       name: name,
                       data: date,
                       text: text,
                       image: UIImage(named: image)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
