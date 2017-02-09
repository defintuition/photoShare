//
//  PhotosTableViewCell.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/8/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewHiearchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func viewHiearchy() {
        self.addSubview(timeStampLabel)
        self.addSubview(voteLabel)
        self.addSubview(nameLabel)
        self.addSubview(profileImage)
    }
    
    func configureConstraints() {
        profileImage.snp.makeConstraints { (view) in
            view.leading.top.bottom.equalToSuperview()
            view.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        
        nameLabel.snp.makeConstraints { (label) in
            label.leading.equalTo(profileImage.snp.trailing).offset(8.0)
            label.top.bottom.equalToSuperview()
        }
        voteLabel.snp.makeConstraints { (label) in
            label.top.bottom.equalToSuperview()
            label.leading.equalTo(nameLabel.snp.trailing).offset(8.0)
        }
        
        timeStampLabel.snp.makeConstraints { (label) in
            label.top.bottom.trailing.equalToSuperview()
        }
    }
    
    lazy var timeStampLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "1:20 PM"
        label.textColor = .lightGray
        return label
    }()
    
    lazy var voteLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Voted Up"
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Victor Zhong"
        return label
    }()
    lazy var profileImage: UIImageView = {
        let profile: UIImageView = UIImageView()
        profile.layer.cornerRadius = 25.0
        profile.layer.masksToBounds = true
        profile.image = #imageLiteral(resourceName: "vic")
        return profile 
    }()
}
