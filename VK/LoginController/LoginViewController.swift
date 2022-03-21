//
//  LoginViewController.swift
//  VK
//
//  Created by Артур Кондратьев on 09.02.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var lableLogin: UILabel!
    @IBOutlet weak var lablePassword: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let hideKeyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyBoardGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWasShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                            object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionAnimate()
        transitionAnimatePassword()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func loginButton(_ sender: Any) {
        if chekData() {
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            showLoginError()
        }
    }
    
    func chekData() -> Bool {
        if loginInput.text == "admin" && passwordInput.text == "12345" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    // клик по любому месту scrollView для скрытия клавиатуры
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    @objc func keyBoardWasShow(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyBoardWillBeHidden(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
    }
    
    @IBAction func segueToLoginController​(segue:UIStoryboardSegue) {
        // проверка и действия
    }
    
    func transitionAnimate() {
        UIView.transition(with: lableLogin,
                          duration: 1,
                          options: [.repeat, .autoreverse, .transitionCrossDissolve],
                          animations: {
            
            self.lableLogin.text = "admin"
        })
    }
    
    func transitionAnimatePassword() {
        UIView.transition(with: lablePassword,
                          duration: 1,
                          options: [.repeat, .autoreverse, .transitionCrossDissolve],
                          animations: {
            self.lablePassword.text = "12345"
        })
    }
}
