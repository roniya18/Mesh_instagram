//
//  LoginViewController.swift
//  Mesh
//
//  Created by alkesh s on 30/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let userNameEmailField : UITextField = {
        let field                       = UITextField()
        field.placeholder               = "User name or Email"
        field.returnKeyType             = .next
        field.leftViewMode              = .always  //for padding
        field.leftView                  = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //for padding
        field.autocapitalizationType    = .none
        field.autocorrectionType        = .no
        field.layer.masksToBounds       = true
        field.layer.cornerRadius        = 8.0
        field.backgroundColor           = .secondarySystemBackground
        return field
    }()
    
    private let passwordField : UITextField = {
        let field                       = UITextField()
        field.placeholder               = "Password"
        field.returnKeyType             = .continue
        field.leftViewMode              = .always
        field.leftView                  = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType    = .none
        field.autocorrectionType        = .no
        field.layer.masksToBounds       = true
        field.layer.cornerRadius        = 8.0
        field.isSecureTextEntry         = true
        field.backgroundColor           = .secondarySystemBackground
        return field
    }()
    
    private let loginButton : UIButton = {
        let button                  = UIButton()
        button.layer.masksToBounds  = true
        button.layer.cornerRadius   = 8.0
        button.backgroundColor      = .systemBlue
        button.setTitle("Log In", for: .normal)
        
        return button
    }()
    
    private let createUserButton : UIButton = {
        let button = UIButton()
        button.setTitle("New User?Create an account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView : UILabel = {
        let text = UILabel()
        text.text = "MESH"
        text.textColor = .systemPurple
        text.font = .italicSystemFont(ofSize: 50)
        text.textAlignment = .center
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        createUserButton.addTarget(self,
                                   action: #selector(didTapCreateUserButton),
                                   for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 25, y: 25, width: view.width - 40, height: 200)
        
        userNameEmailField.frame = CGRect(x: 25,
                                          y: headerView.bottom + 10,
                                          width: view.width - 40 ,
                                          height: 52)
        passwordField.frame      = CGRect(x: 25,
                                          y: userNameEmailField.bottom + 10,
                                          width: view.width - 40 ,
                                          height: 52)
        loginButton.frame        = CGRect(x: 25,
                                          y: passwordField.bottom + 20,
                                          width: 350 ,
                                          height: 52)
        createUserButton.frame   = CGRect(x: 25,
                                          y: loginButton.bottom + 20,
                                          width: 350 ,
                                          height: 52)
        
    }
    
    private func addSubViews(){
        view.addSubview(headerView)
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createUserButton)
    }
    
    @objc private func didTapLoginButton(){
        //dissmiss the keyboard
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let emailUserName = userNameEmailField.text , !emailUserName.isEmpty,
              let password = passwordField.text , !password.isEmpty else {return}
        
        var userName : String?
        var email : String?
        
        if emailUserName.contains("@"),emailUserName.contains("."){
            email = emailUserName
        }
        else{
            userName = emailUserName
        }
        
        AuthManager.shared.Login(userName: userName, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success{
                    self.dismiss(animated: true,completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Invalid Username or Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc private func didTapCreateUserButton(){
        let vc = RegisterViewController()
        vc.title = "Create New Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
