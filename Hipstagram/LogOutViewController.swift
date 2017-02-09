//
//  LogOutViewController.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        //logout
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    func handleLogOut(){
        dismiss(animated: true, completion: nil)
    }
    

}
