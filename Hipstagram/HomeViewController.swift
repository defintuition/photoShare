//
//  HomeViewController.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red:0.38, green:0.49, blue:0.55, alpha:1.0)
        //logout
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut))
        
        setupView()
        setupViewConfiguration()
        
        checkUserLogin()
        
    }
    
    func checkUserLogin(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            self.perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        }else{
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("User").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    if let coverImage = dictionary["profileImageURL"] as? String {
                        let url = URL(string: coverImage)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil{
                                print("There is an error: \(error)")
                            }
                            
                            DispatchQueue.main.async {
                                if let downloadImage = UIImage(data: data!){
                                    self.coverPicture.image = downloadImage
                                }
                            }
                        }).resume()
                        print(snapshot)
                        
                    }
                }
                
            })
            
            FIRDatabase.database().reference().child("User").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    self.navigationItem.title = dictionary["email"] as? String
                }
                
                print(snapshot)
            })
            
        }
    }
    
    func handleLogOut(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        
        //let loginController = LoginViewController()
        self.navigationController?.popViewController(animated: true)
        //        pop(loginController, animated: true, completion: nil)
    }
    
    func setupView(){
        view.addSubview(coverPicture)
        view.addSubview(containerView)
        view.addSubview(collectionView)
    }
    
    func setupViewConfiguration(){
        coverPicture.snp.makeConstraints { (view) in
            view.leading.equalToSuperview()
            view.top.equalToSuperview()
            view.height.equalTo(180)
            view.width.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { (view) in
            view.leading.equalToSuperview()
            view.top.equalTo(coverPicture.snp.bottom)
            view.width.equalToSuperview()
            view.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (view) in
            view.leading.trailing.bottom.equalToSuperview()
            view.height.equalTo(150)
        }
    }
    
    internal lazy var coverPicture: UIImageView = {
        let cp = UIImageView()
        return cp
    }()
    
    internal lazy var containerView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    internal lazy var collectionView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .gray
        return cv
    }()
    
}
