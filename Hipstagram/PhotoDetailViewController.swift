//
//  PhotoDetailViewController.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/8/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "voteFeedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        votesTableView.delegate = self
        votesTableView.dataSource = self
        votesTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        votesTableView.estimatedRowHeight = 100
        votesTableView.rowHeight = UITableViewAutomaticDimension
        viewHiearchy()
        configuredConstraint()
    }
    
    // MARK: - View Hiearchy and Constraints
    
    func viewHiearchy() {
        self.view.addSubview(topPhoto)
        self.view.addSubview(votesTableView)
        self.topPhoto.addSubview(upLabel)
        self.topPhoto.addSubview(downLabel)
        self.topPhoto.addSubview(upButton)
        self.topPhoto.addSubview(downButton)
    }
    
    func configuredConstraint() {
        topPhoto.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.5)
        }
        votesTableView.snp.makeConstraints { (tableview) in
            tableview.bottom.leading.trailing.equalToSuperview()
            tableview.height.equalToSuperview().multipliedBy(0.5)
        }
        upLabel.snp.makeConstraints { (view) in
            view.leading.bottom.equalToSuperview()
            view.trailing.equalTo(topPhoto.snp.centerX)
            view.height.equalTo(30.0)
        }
        downLabel.snp.makeConstraints { (view) in
            view.trailing.bottom.equalToSuperview()
            view.leading.equalTo(topPhoto.snp.centerX)
            view.height.equalTo(30.0)
        }
        upButton.snp.makeConstraints { (view) in
            view.leading.equalToSuperview()
            view.bottom.equalTo(upLabel.snp.top)
            view.trailing.equalTo(topPhoto.snp.centerX)
            view.height.equalTo(30.0)
        }
        downButton.snp.makeConstraints { (view) in
            view.trailing.equalToSuperview()
            view.bottom.equalTo(downLabel.snp.top)
            view.leading.equalTo(topPhoto.snp.centerX)
            view.height.equalTo(30.0)
        }

    }
    
    //MARK: - TableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PhotosTableViewCell
        
        cell.profileImage.layer.cornerRadius = 25.0
        return cell
        
    }
    lazy var votesTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var upButton : UIButton = {
        let upButton = UIButton()
        //upButton.imageView?.image = #imageLiteral(resourceName: "up_arrow")
        upButton.setImage(#imageLiteral(resourceName: "up_arrow"), for: .normal)
        upButton.alpha = 0.50
        upButton.backgroundColor = UIColor(red:0.38, green:0.49, blue:0.55, alpha:1.0)
        return upButton
    }()
    lazy var downButton : UIButton = {
        let downButton = UIButton()
        //downButton.imageView?.image = #imageLiteral(resourceName: "down_arrow")
        downButton.setImage(#imageLiteral(resourceName: "down_arrow"), for: .normal)
        downButton.alpha = 0.50
        downButton.backgroundColor = UIColor(red:0.38, green:0.49, blue:0.55, alpha:1.0)
        return downButton
    }()
    lazy var upLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
        label.textColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    lazy var downLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
        label.textColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        label.text = "2"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var topPhoto: UIImageView = {
        let photoView : UIImageView = UIImageView()
        photoView.contentMode = .scaleAspectFill
        photoView.image = #imageLiteral(resourceName: "vic")
        return photoView
    }()
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
