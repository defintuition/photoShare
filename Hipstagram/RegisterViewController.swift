//
//  RegisterViewController.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//


import UIKit
import Firebase
import SnapKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        
        setupView()
        setupViewContainer()
        setUpRegisterButton()
        
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        
    }
    
    func registerUser(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print("Error encountered: \(error)")
            }
            
            
            guard let uid = user?.uid else {return}
            
            let ref = FIRDatabase.database().reference(fromURL: "https://hipstergram-3fdf8.firebaseio.com/")
            let userReference = ref.child("Users").child(uid)
            
            let value = ["email": email, "password": password ]
            
            userReference.updateChildValues(value) { (error, reference) in
                if error != nil{
                    print("Error encountered: \(error)")
                }
                
            }
            
        })
        
        let navViewController = UINavigationController(rootViewController: LogOutViewController())
        self.present(navViewController, animated: true, completion: nil)
        
    }
    
    func setupView(){
        
        view.addSubview(registerContainer)
        view.addSubview(registerButton)
        view.addSubview(signIn)
        registerContainer.addSubview(nameTextField)
        registerContainer.addSubview(emailTextField)
        registerContainer.addSubview(passwordTextField)
        
    }
    
    func setupViewContainer(){
        
        //Container
        
        registerContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registerContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        registerContainer.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        //Name
        nameTextField.leadingAnchor.constraint(equalTo: registerContainer.leadingAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: registerContainer.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: registerContainer.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: registerContainer.heightAnchor, multiplier: 0.33).isActive = true
        
        //Email Address
        emailTextField.leadingAnchor.constraint(equalTo: registerContainer.leadingAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: registerContainer.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: registerContainer.heightAnchor, multiplier: 0.33).isActive = true
        
        
        //password
        passwordTextField.leadingAnchor.constraint(equalTo: registerContainer.leadingAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: registerContainer.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: registerContainer.heightAnchor, multiplier: 0.33).isActive = true
    }
    
    func setUpRegisterButton(){
        registerButton.leadingAnchor.constraint(equalTo: registerContainer.leadingAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: registerContainer.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: registerContainer.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: registerContainer.heightAnchor, multiplier: 0.33).isActive = true
        
        signIn.leadingAnchor.constraint(equalTo: registerContainer.leadingAnchor).isActive = true
        signIn.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 12).isActive = true
        signIn.widthAnchor.constraint(equalTo: registerContainer.widthAnchor).isActive = true
        signIn.heightAnchor.constraint(equalTo: registerContainer.heightAnchor, multiplier: 0.33).isActive = true
        
    }
    
    let registerContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .gray
        container.layer.cornerRadius = 5
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let nameTextField: UITextField = {
        let name =   UITextField()
        name.backgroundColor = .white
        name.placeholder = "  Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let emailTextField: UITextField = {
        let email =   UITextField()
        email.backgroundColor = .white
        email.placeholder = "  EmailAddress"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let passwordTextField: UITextField = {
        let password =   UITextField()
        password.backgroundColor = .white
        password.placeholder = "  Password"
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signIn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("SignIn", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
}
