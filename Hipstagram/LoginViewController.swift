//
//  LoginViewController.swift
//  programmaticLayout
//
//  Created by Amber Spadafora on 2/6/17.
//  Copyright © 2017 C4Q. All rights reserved.
//
import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
// Test
    
    override func viewDidLayoutSubviews() {
        userNameTextField.addTextFieldFormatting(placeholder: "USERNAME")
        passwordTextField.addTextFieldFormatting(placeholder: "PASSWORD")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        self.title = "LOGIN / REGISTER"
        setupViewHierarchy()
        addConstraints()
    }
    
    // MARK: Configure Views & SubViews
    
    private func addConstraints() {
        self.edgesForExtendedLayout = []
        
        self.userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logginButton.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        logoImageView.snp.makeConstraints { (image) in
            image.centerX.equalToSuperview()
            image.height.equalTo(152)
            image.width.equalTo(152)
            image.top.equalToSuperview().offset(8.0)

        }
        
        userNameTextField.snp.makeConstraints { (textField) in
            textField.leading.equalTo(self.view.snp.leadingMargin).offset(8.0)
            textField.trailing.equalTo(self.view.snp.trailingMargin).offset(-8.0)
            textField.height.equalTo(35)
            textField.top.equalTo(logoImageView.snp.bottom).offset(8.0)
        }
        
        passwordTextField.snp.makeConstraints { (textField) in
            textField.leading.equalTo(self.view.snp.leadingMargin).offset(8.0)
            textField.trailing.equalTo(self.view.snp.trailingMargin).offset(-8.0)
            textField.height.equalTo(35)
            textField.top.equalTo(userNameTextField.snp.bottom).offset(16.0)
        }
        
        
        signUpButton.snp.makeConstraints { (button) in
            button.width.equalTo(view.snp.width).multipliedBy(0.65)
            button.height.equalTo(40)
        }
        
        logginButton.snp.makeConstraints { (button) in
            button.width.equalTo(view.snp.width).multipliedBy(0.65)
            button.height.equalTo(40)
        }
        
        buttonStackView.snp.makeConstraints { (stack) in
            stack.bottom.equalTo(view.snp.bottom).inset(16.0)
            stack.centerX.equalTo(view.snp.centerX)
        }
        
        
        
        
    }
    private func setupViewHierarchy() {
        self.view.addSubview(userNameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(logoImageView)
        self.view.addSubview(buttonStackView)
        
    }


    
    
    // MARK: -
    
    internal lazy var userNameTextField: UITextField = {
        let view: UITextField = UITextField()
        view.textColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        return view
    }()
    
    internal lazy var passwordTextField: UITextField = {
        let view: UITextField = UITextField()
        view.textColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        view.isSecureTextEntry = true
        return view
    }()
    
    
    
    internal lazy var logoImageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = #imageLiteral(resourceName: "logo")
        view.layer.cornerRadius = 76
        view.layer.masksToBounds = true
        view.contentMode = UIViewContentMode.scaleAspectFit
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImageFromLibrary)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    internal lazy var logginButton: UIButton = {
        let view: UIButton = UIButton.init(type: .custom)
        view.backgroundColor = self.backgroundColor
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        view.setTitle("LOGIN", for: UIControlState.normal)
        view.titleLabel?.textColor = UIColor.black
        view.addTarget(self, action: #selector(signInUser), for: .touchUpInside)
        return view
    }()
    
    internal lazy var signUpButton: UIButton = {
        let view: UIButton = UIButton(type: .custom)
        view.backgroundColor = self.backgroundColor
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
        view.setTitle("REGISTER", for: UIControlState.normal)
        view.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        view.titleLabel?.textColor = UIColor.black
        return view
    }()
    
    internal lazy var buttonStackView: UIStackView = {
        let view: UIStackView = UIStackView(arrangedSubviews: [self.logginButton, self.signUpButton])
        view.alignment = UIStackViewAlignment.fill
        view.distribution = UIStackViewDistribution.fillEqually
        view.axis = .vertical
        view.spacing = 8.0
        return view
    }()
    
    // MARK: TextField Delegates
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTextField:
            userNameTextField.resignFirstResponder()
            return true
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            return true
        default:
            return true
        }
        
    }
    

    
    // MARK: Colors
    
    let backgroundColor = UIColor(red:0.38, green:0.49, blue:0.55, alpha:1.0)
    
    
}
