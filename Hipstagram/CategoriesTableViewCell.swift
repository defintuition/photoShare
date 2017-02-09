//
//  CategoriesTableViewCell.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit

class CategoriesTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(cellImage)
        self.addSubview(blackView)
        self.addSubview(cellLabel)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureConstraints() {
        cellImage.snp.makeConstraints { (view) in
            view.bottom.top.leading.trailing.equalToSuperview()
        }
        blackView.snp.makeConstraints { (view) in
            view.bottom.top.leading.trailing.equalToSuperview()
        }
        
        cellLabel.snp.makeConstraints({ (label) in
            label.center.equalToSuperview()
            label.top.equalToSuperview().offset(80.0)
            label.bottom.equalToSuperview().inset(80.0)
            label.width.equalToSuperview().multipliedBy(0.60)
        })
    }
    //MARK: - Views Set up
    lazy var cellLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 3
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    lazy var blackView: UIView  = {
        let view : UIView = UIView()
        view.backgroundColor = .black
        view.alpha = 0.25
        return view
    }()
    
    lazy var cellImage: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
}
