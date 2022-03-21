//
//  FriendsListController.swift
//  VK
//
//  Created by Артур Кондратьев on 10.02.2022.
//

import UIKit

/// Сценарий списка друзей
final class FriendsListController: UITableViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var friends = FriendsLoader.iNeedFriends()
    private var lettersOfNames = [String]()
    lazy var filteredFriends = friends
    
    func searchBarAnimateClosure () -> () -> Void {
        return {
            guard
                let scopeView = self.searchBar.searchTextField.leftView,
                let placeholderLabel = self.searchBar.textField?.value(forKey: "placeholderLabel") as?
                    UILabel
            else {
                return
            }
            
            UIView.animate(withDuration: 0.3,
                           animations: {
                scopeView.frame = CGRect(x: self.searchBar.frame.width / 2 - 15,
                                         y: scopeView.frame.origin.y,
                                         width: scopeView.frame.width,
                                         height: scopeView.frame.height)
                placeholderLabel.frame.origin.x -= 20
                self.searchBar.layoutSubviews()
            })
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.sectionHeaderHeight = 30.0
        searchBar.delegate = self
        loadLetters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            UIView.animate(withDuration: 0, animations: self.searchBarAnimateClosure())
        })
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends[section].data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = friends[section]
        
        return String(section.key)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersOfNames
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                     for: indexPath) as? FriendsListCell
        else {
            return UITableViewCell()
        }
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 10
        
        let section = filteredFriends[indexPath.section]
        
        cell.configure(model: section.data[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(section: section)    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CurrentFriendController {
            guard
                let vc = segue.destination as? CurrentFriendController,
                let indexPathSection = tableView.indexPathForSelectedRow?.section,
                let indexPathRow = tableView.indexPathForSelectedRow?.row
            else {
                return
            }
            let section = filteredFriends[indexPathSection]
            vc.friend = section.data[indexPathRow].storedImages
            
        }
    }
}

// MARK: - UISearchBarDelegate
extension FriendsListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriends = []
        
        if searchText == "" {
            filteredFriends = friends
        } else {
            for section in friends {
                for (_, friend) in section.data.enumerated() {
                    if friend.name.lowercased().contains(searchText.lowercased()) {
                        var searchedSection = section
                        
                        if filteredFriends.isEmpty {
                            searchedSection.data = [friend]
                            filteredFriends.append(searchedSection)
                            break
                        }
                        var found = false
                        for (sectionIndex, filteredSection) in filteredFriends.enumerated() {
                            if filteredSection.key == section.key {
                                filteredFriends[sectionIndex].data.append(friend)
                                found = true
                                break
                            }
                        }
                        if !found {
                            searchedSection.data = [friend]
                            filteredFriends.append(searchedSection)
                        }
                    }
                }
            }
        }
        self.tableView.reloadData()
    }
    
    // отмена поиска
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // показать кнопку кансл
        
        let cBtn = searchBar.value(forKey: "cancelButton") as! UIButton
        cBtn.backgroundColor = .lightGray
        cBtn.setTitleColor(.white, for: .normal)
        
        UIView.animate(withDuration: 0.3,
                       animations: {
            // Двигаем кнопку кансл
            cBtn.frame = CGRect(x: cBtn.frame.origin.x - 50,
                                y: cBtn.frame.origin.y,
                                width: cBtn.frame.width,
                                height: cBtn.frame.height)
            
            // Анимируем запуск поиска. -1 чтобы пошла анимация, тогда лупа плавно откатывается
            self.searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
                                          y: self.searchBar.frame.origin.y,
                                          width: self.searchBar.frame.size.width - 1,
                                          height: self.searchBar.frame.size.height)
            self.searchBar.layoutSubviews()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Анимацию возвращения в исходное состояние после нажатия кансл
        UIView.animate(withDuration: 0.2,
                       animations: {
            searchBar.showsCancelButton = false // скрываем кнопку кансл
            searchBar.text = nil
            searchBar.resignFirstResponder() // скрываем клавиатуру
        }, completion: { _ in
            let closure = self.searchBarAnimateClosure()
            closure()
        })
    }
}

// MARK: - Private
private extension FriendsListController {
    func loadLetters() {
        for user in friends {
            lettersOfNames.append(String(user.key))
        }
    }
    
    func createHeaderView(section: Int) -> UIView {
        let header = GradientView()
        header.startColor = .systemBlue
        header.endColor = .white
        
        let letter = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        letter.textColor = .white
        letter.text = lettersOfNames[section]
        letter.font = UIFont.systemFont(ofSize: 20)
        header.addSubview(letter)
        return header
    }
}

import UIKit

extension UISearchBar {
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap {$0.subviews}
        guard let textField = (subViews.filter {$0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    func clearBackgraundColor() {
        guard let UISearchBarBackgraund: AnyClass = NSClassFromString("UISearchBarBackgraund") else {return}
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearchBarBackgraund) {
                subview.alpha = 0
            }
        }
    }
    
    func changePlaceholderColor(_ color: UIColor) {
        guard let UISearchBarTextFieldLable: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
              let field = textField else {
                  return
              }
        for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLable) {
            (subview as! UILabel).textColor = color
        }
    }
    
    func setRightImage(normalImage: UIImage,
                       highLightedImage: UIImage) {
        showsBookmarkButton = true
        if let btn = textField?.rightView as? UIButton {
            btn.setImage(normalImage,
                         for: .normal)
            btn.setImage(highLightedImage,
                         for: .highlighted)
        }
    }
    
    func setLeftImage(_ image: UIImage,
                      with padding: CGFloat = 0,
                      tintColor: UIColor) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = tintColor
        
        if padding != 0 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            textField?.leftView = stackView
            
        } else {
            textField?.leftView = imageView
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
}
