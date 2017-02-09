//
//  UploadViewController.swift
//  Hipstagram
//
//  Created by Annie Tung on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import Photos
import FirebaseStorage
import MobileCoreServices

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties and outlets

    
    var databaseReference: FIRDatabaseReference!
    var storageReference: FIRStorageReference!
    var databaseObserver: FIRDatabaseHandle?
    var counter = 1
    let date = Date()
    let manager = PHImageManager.default()
    var topTierFetchResult = PHFetchResult<PHCollection>()
    let categories = ["Food","Museums","Pets","Travel","Coffee Shops","Music Festivals","Fashion","Way Too Hipster For You"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressbarView.isHidden = true
        // Using anonymous authentication for Firebase Storage
        FIRAuth.auth()?.signInAnonymously() { (user, error) in
            if let error = error {
                let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                print("Logged in successfully!")
                dump(user?.uid)
            }
        }
        databaseReference = FIRDatabase.database().reference()
        storageReference = FIRStorage.storage().reference()
        
        // create unique category ID:
        //        for all in categories {
        //            createCat(name: all)
        //        }
        
        self.title = "UPLOAD"
        self.view.backgroundColor = backgroundColor
        setUpViewHierarchy()
        addConstraints()
        fetchMomentsList()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        largePhotoCollectionView.delegate = self
        largePhotoCollectionView.dataSource = self
        thumbnailPhotoCollectionView.delegate = self
        thumbnailPhotoCollectionView.dataSource = self
        
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        largePhotoCollectionView.register(largePhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        thumbnailPhotoCollectionView.register(ThumbNailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        titleTextField.addTextFieldFormatting(placeholder: "TITLE")
    }
    
    // MARK: - Imagepicker and Firebase Storage
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Error with ImagePickerControllerOriginalImage")
            return
        }
        if let imageData = UIImageJPEGRepresentation(image, 0.8) {
            progressbarView.isHidden = false
            let databaseRef = self.databaseReference.child("Image")
            let newItemRef = databaseRef.childByAutoId()
            // store key for storage
            let uniqueKey = newItemRef.key
            dump(uniqueKey)
            
            let newItem = Image(uid: (FIRAuth.auth()?.currentUser?.uid)!, date: date.dateString, categoryID: "KcUZcgab1cJeLO5VA-O", imagePath: uniqueKey, upvote: 1)
            let newItemDetails: [String : AnyObject] = [
                "uid" : newItem.uid as AnyObject,
                "date" : newItem.date as AnyObject,
                "categoryID" : newItem.categoryID as AnyObject,
                "imagePath" : newItem.imagePath as AnyObject,
                "upvote" : newItem.upvote as AnyObject
            ]
            newItemRef.setValue(newItemDetails)
            
            //update storage
            let storageRef = self.storageReference.child("Image").child(uniqueKey)
            let uploadMetadata = FIRStorageMetadata()
            uploadMetadata.contentType = "image/jpeg"
            
            let uploadTask = storageRef.put(imageData, metadata: uploadMetadata, completion: { (metaData, error) in
                if let error = error {
                    print("Error encountered: \(error.localizedDescription)")
                    return
                }
            })
            self.dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                // NEED TO FIX:
                //                largePhotoImageView.image = UIImage(data: imageData)
                print("***** Getting image data: \(imageData)")
            }
            
            // observer gets triggered everytime uploadTask uploads data. UploadTask object will automatically remove observers on itself when done
            uploadTask.observe(FIRStorageTaskStatus.progress) { (snapshot) in
                guard let progress = snapshot.progress else { return }
                print(progress)
                self.progressBar.progress = Float(progress.fractionCompleted)
            }
            uploadTask.observe(FIRStorageTaskStatus.success) { (snapshot) in
                print("Upload success!")
                self.progressLabel.text = "SUCCESS!"
                self.progressBar.isHidden = true
                self.delay(4.0, closure: {
                    self.progressbarView.isHidden = true
                })
            }
        }
    }
    
    // MARK: - Firebase Database Observer
    
    private func setObserver() {
        databaseObserver = databaseReference.observe(.childAdded, with: { (snapshot: FIRDataSnapshot) in
            dump(snapshot)
        })
    }
    
    // MARK: - Actions
    
    @IBAction func upvoteButtonPressed(_ sender: UIButton) {
        print("upvote!")
        
        databaseReference.ref.updateChildValues(["upvote" : counter]) { (error, FIRDatabaseReference) in
            self.counter += 1
        }
    }
    
    @IBAction func downvoteButtonPressed(_ sender: UIButton) {
        print("downvote!")
        
        databaseReference.ref.updateChildValues(["upvote" : counter]) { (error, FIRDatabaseReference) in
            self.counter -= 1
        }
    }
    
    // MARK: - Methods
    
    func createCat(name: String) {
        let databaseRef = FIRDatabase.database().reference().child("Category")
        let newCat = databaseRef.childByAutoId()
        let newItem: [String:AnyObject] = [
            "name" : name as AnyObject
        ]
        newCat.setValue(newItem)
    }
    
    func uploadButtonPressed() {
        print("upload button pressed")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [String(kUTTypeImage)]
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case tagCollectionView:
            return 1
        case largePhotoCollectionView:
            return 1
        case thumbnailPhotoCollectionView:
            guard topTierFetchResult.count > 0 else { return 1 }
            return topTierFetchResult.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case tagCollectionView:
            return 5
        case largePhotoCollectionView:
            return 5
        case thumbnailPhotoCollectionView:
            let section = topTierFetchResult[section] as! PHAssetCollection
            let assets = PHAsset.fetchAssets(in: section, options: nil)
            return assets.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case tagCollectionView:
            let cell: TagCollectionViewCell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TagCollectionViewCell
            cell.backgroundColor = self.backgroundColor
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1.0
            cell.cellLabel.text = "Tag"
            
            return cell
            
        case largePhotoCollectionView:
            let cell: largePhotoCollectionViewCell = largePhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! largePhotoCollectionViewCell
            cell.backgroundColor = self.backgroundColor
            cell.largePhotoImageView.image = #imageLiteral(resourceName: "logo")
            
            return cell
            
        case thumbnailPhotoCollectionView:
            let cell: ThumbNailCollectionViewCell = thumbnailPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ThumbNailCollectionViewCell
            
            let collection = topTierFetchResult[indexPath.section] as! PHAssetCollection
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            let asset = assets[indexPath.row]
            
            manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFill, options: nil) { (result, _) in
                DispatchQueue.main.async {
                    cell.thumbPhotoImageView.image = result
                    //            cell.testLabel?.text = "\(indexPath.section):\(indexPath.row)"
                    cell.setNeedsLayout()
                    print(asset)
                }
            }
            return cell
            
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    // MARK: - Photos Asset Collections
    
    func fetchMomentsList() {
        print("\n---Moments List---\n")
        let options = PHFetchOptions()
        
        let momentsLists = PHCollectionList.fetchMomentLists(with: .momentListCluster, options: nil)
        
        for i in 0..<momentsLists.count {
            print("Title: ", momentsLists[i].localizedTitle ?? "no title available")
            let moments = momentsLists[i]
            let collectionList = PHCollectionList.fetchCollections(in: moments, options:options)
            
            self.topTierFetchResult = collectionList
            for j in 0..<collectionList.count {
                if let collection = collectionList[j] as? PHAssetCollection {
                    printAssetsInList(collection: collection)
                }
            }
        }
    }
    
    func printAssetsInList(collection: PHAssetCollection) {
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        print("\n---\(assets.count)---\n")
        for j in 0..<assets.count {
            print(assets[j])
            if j > 20 {
                print("Only fetching 20 photos at the moment")
                break
            }
        }
    }
    
    // MARK: - Set Up View (configure constraints etc.)
    
    private func setUpViewHierarchy(){
        self.view.addSubview(titleTextField)
        self.view.addSubview(tagCollectionView)
        self.view.addSubview(largePhotoCollectionView)
        self.view.addSubview(thumbnailPhotoCollectionView)
        self.view.addSubview(progressbarView)
        progressbarView.addSubview(progressLabel)
        progressbarView.addSubview(progressBar)
        self.navigationItem.rightBarButtonItem = uploadButtonItem
    }
    
    private func addConstraints(){
        self.edgesForExtendedLayout = []
        
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.largePhotoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailPhotoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let largePhotoCVheight = (self.view.frame.height - self.tagCollectionView.frame.height) - (self.thumbnailPhotoCollectionView.frame.height - self.titleTextField.frame.height) - ((self.tabBarController?.tabBar.frame.height)! - (self.navigationController?.navigationBar.frame.height)!)
        
        titleTextField.snp.makeConstraints { (textField) in
            textField.leading.equalTo(self.view.snp.leading).offset(16.0)
            textField.trailing.equalTo(self.view.snp.trailing).inset(16.0)
            textField.height.equalTo(30)
            textField.top.equalTo(self.view.snp.top).offset(8.0)
            
        }
        
        tagCollectionView.snp.makeConstraints { (collectionView) in
            collectionView.leading.equalTo(self.view.snp.leading)
            collectionView.trailing.equalTo(self.view.snp.trailing)
            collectionView.height.equalTo(40)
            collectionView.top.equalTo(titleTextField.snp.bottom)
            
        }
        
        largePhotoCollectionView.snp.makeConstraints { (collectionView) in
            collectionView.leading.equalTo(self.view.snp.leading)
            collectionView.trailing.equalTo(self.view.snp.trailing)
            collectionView.height.equalTo(largePhotoCVheight - 2)
            collectionView.top.equalTo(tagCollectionView.snp.bottom).offset(8.0)
            collectionView.bottom.equalTo(thumbnailPhotoCollectionView.snp.top).offset(2.0)
            
            
        }
        
        thumbnailPhotoCollectionView.snp.makeConstraints { (collectionView) in
            collectionView.leading.equalTo(self.view.snp.leading)
            collectionView.trailing.equalTo(self.view.snp.trailing)
            collectionView.height.equalTo(100)
            collectionView.top.equalTo(largePhotoCollectionView.snp.bottom)
            collectionView.bottom.equalTo(self.view.snp.bottom)
        }
        
        progressbarView.snp.makeConstraints { (pbv) in
            pbv.centerX.equalTo(view.snp.centerX)
            pbv.centerY.equalTo(view.snp.centerY)
            pbv.height.equalTo(75)
            pbv.width.equalToSuperview().multipliedBy(0.65)
            
        }
        
        progressLabel.snp.makeConstraints { (label) in
            label.top.equalTo(progressbarView.snp.top).offset(16.0)
            label.centerX.equalTo(progressbarView.snp.centerX)
        }
        
        progressBar.snp.makeConstraints { (bar) in
            bar.centerX.equalTo(progressbarView.snp.centerX)
            bar.top.equalTo(progressLabel.snp.bottom)
            bar.width.equalTo(progressbarView.snp.width).multipliedBy(0.8)
        }
    }
    
    // MARK: - Define Subviews
    
    internal lazy var titleTextField: UITextField = {
        let view: UITextField = UITextField()
        view.textColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        view.useUnderline()
        view.useYellowPlaceHolderText(placeholderText: "TITLE")
        return view
    }()
    
    
    internal lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 25)
        let frame: CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)
        let view: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.backgroundColor = self.backgroundColor
        return view
    }()
    
    internal lazy var uploadButtonItem: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(uploadButtonPressed))
        button.image = #imageLiteral(resourceName: "down_arrow")
        button.tintColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        return button
    }()
    
    internal lazy var largePhotoCollectionView: UICollectionView = {
        
        var largePhotoCVheight = (self.view.frame.height - self.tagCollectionView.frame.height) - (self.thumbnailPhotoCollectionView.frame.height - self.titleTextField.frame.height) - ((self.tabBarController?.tabBar.frame.height)! - (self.navigationController?.navigationBar.frame.height)!)
        
        largePhotoCVheight -= 8
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.view.frame.width, height: largePhotoCVheight)
        let frame: CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: largePhotoCVheight)
        let view: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.backgroundColor = self.backgroundColor
        return view
    }()
    
    internal lazy var thumbnailPhotoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let frame: CGRect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        let view: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.backgroundColor = self.backgroundColor
        return view
    }()
    
    
    internal lazy var progressbarView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = self.backgroundColor
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    internal lazy var progressLabel: UILabel = {
        let view: UILabel = UILabel()
        view.text = "UPLOADING..."
        view.textColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        return view
    }()
    
    internal lazy var progressBar: UIProgressView = {
        let view: UIProgressView = UIProgressView()
        view.progressTintColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        view.setProgress(0.5, animated: true)
        return view
    }()
    
    // MARK: - Colors
    
    let backgroundColor = UIColor(red:0.38, green:0.49, blue:0.55, alpha:1.0)
    
    // MARK: Helper Functions
    private func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
}
