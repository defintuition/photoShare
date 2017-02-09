//
//  LoginViewController+Helper.swift
//  HIPSTAGRAM
//
//  Created by Thinley Dorjee on 2/8/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func registerUser() {
        
        guard let email = userNameTextField.text, let password = passwordTextField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        
                        let alertController = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                        
                        
                    case .errorCodeEmailAlreadyInUse:
                        
                        let alertController = UIAlertController(title: "Error", message: "Email is taken", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        return

                    default:
                        let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                    
                    
                }
                
               
            }
            
            guard let uid = user?.uid else { return }
            
            let imageName = NSUUID().uuidString
            
            let storage = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(self.logoImageView.image!){
                
                storage.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print("Error encountered: \(error)")
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let value = ["email": email, "profileImageURL": profileImageUrl]
                        
                        self.registerUserIntoDatabaseWithUID(uid: uid, value: value as [String : AnyObject])
                    }
                    
                })
            }
            
            
        })
        
        
    }
    
    func registerUserIntoDatabaseWithUID(uid: String, value: [String: AnyObject]){
        let ref = FIRDatabase.database().reference(fromURL: "https://hipstagram-a86e0.firebaseio.com/")
        let userReference = ref.child("User").child(uid)
        userReference.updateChildValues(value, withCompletionBlock: { (err, ref) in
            if err != nil{
                
                print("There is an error: \(err)")
           
            }
            
            if let nav = self.navigationController {
                let homeViewController = HomeViewController()
                nav.pushViewController(homeViewController, animated: true)
                nav.navigationItem.hidesBackButton = true
            }
        })
        
    }
    
    
    func pickImageFromLibrary(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.logoImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancelled to picked a image")
        dismiss(animated: true, completion: nil)
    }
    
    func signInUser(){
        guard let email = userNameTextField.text, let password = passwordTextField.text else { return }
   
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    print("There is an error: \(error)")
                }
                if let nav = self.navigationController {
                    let homeViewController = HomeViewController()
                    nav.pushViewController(homeViewController, animated: true)
                    nav.navigationItem.hidesBackButton = true
                }
                
            })
        
        
    }
}

