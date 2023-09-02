//
//  RegisterViewController.swift
//  Mesh
//
//  Created by alkesh s on 30/08/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let userNameField : UITextField = {
        let field                       = UITextField()
        field.placeholder               = "User name "
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
    private let emailField : UITextField = {
        let field                       = UITextField()
        field.placeholder               = "Email"
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
    
    private let signUpButton : UIButton = {
        let button                  = UIButton()
        button.layer.masksToBounds  = true
        button.layer.cornerRadius   = 8.0
        button.backgroundColor      = .systemBlue
        button.setTitle("Sign Up", for: .normal)
        
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
        signUpButton.addTarget(self,
                               action: #selector(didTapSignUpButton),
                               for: .touchUpInside)
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 25,
                                  y: 25,
                                  width: view.width - 40,
                                  height: 200)
        userNameField.frame = CGRect(x: 25,
                                     y: headerView.bottom + 20,
                                     width: view.width - 40,
                                     height: 52)
        emailField.frame = CGRect(x: 25,
                                     y: userNameField.bottom + 10,
                                     width: view.width - 40,
                                     height: 52)
        passwordField.frame = CGRect(x: 25,
                                     y: emailField.bottom + 10,
                                     width: view.width - 40,
                                     height: 52)
        signUpButton.frame = CGRect(x: 25,
                                     y: passwordField.bottom + 20,
                                     width: view.width - 40,
                                     height: 52)
    }
    
    private func addSubviews(){
        view.addSubview(headerView)
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
    }
    
    @objc private func didTapSignUpButton(){
        userNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let userName = userNameField.text , !userName.isEmpty,
              let email = emailField.text , !email.isEmpty,
              let password = passwordField.text , !password.isEmpty, password.count >= 8 else{
                  
                  let alert = UIAlertController(title: "Error", message: "All Fields Must Be filled and password must have minimum 8 character", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                  self.present(alert, animated: true)
                  return
                  
              }
        
        AuthManager.shared.Register(userName: userName, email: email, password: password){ registerd in
            DispatchQueue.main.async {
                if registerd{
                    RegisterViewController().dismiss(animated: true)
                }
                else{
                    
                }
            }
        }
    }
}

extension RegisterViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField{
            emailField.becomeFirstResponder()
        }
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapSignUpButton()
        }
        return true
    }
}
