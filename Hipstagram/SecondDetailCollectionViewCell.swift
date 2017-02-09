//
//  SecondDetailCollectionViewCell.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/8/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit

class SecondDetailCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier:String = "secondCellId"
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(cellImage)
        self.addSubview(container)
        container.addSubview(up)
        container.addSubview(down)
        container.addSubview(upLabel)
        container.addSubview(downLabel)
        self.addSubview(blackView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        cellImage.snp.makeConstraints { (image) in
            image.top.bottom.leading.trailing.equalToSuperview()
        }
        container.snp.makeConstraints { (view) in
            view.trailing.equalToSuperview().offset(-8.0)
            view.bottom.equalToSuperview().inset(8.0)
            view.size.equalTo(CGSize(width: 50, height: 50))
        }
        up.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview()
        }
        down.snp.makeConstraints { (view) in
            view.bottom.leading.equalToSuperview()
            
        }
        upLabel.snp.makeConstraints { (view) in
            view.top.trailing.equalToSuperview()
        }
        downLabel.snp.makeConstraints { (view) in
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
        blackView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - UI Items Set Up 
    
    lazy var cellImage: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    lazy var container: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var up: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.image = #imageLiteral(resourceName: "up_arrow")
        image.image =  image.image?.maskWithColor(color: .white)
        return image
    }()
    lazy var down: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.image = #imageLiteral(resourceName: "down_arrow")
        image.image =  image.image?.maskWithColor(color: .white)
        return image
    }()
    lazy var upLabel: UILabel  = {
        let label : UILabel = UILabel()
        label.text = "15"
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var downLabel: UILabel  = {
        let label : UILabel = UILabel()
        label.text = "6"
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    lazy var blackView: UIView  = {
        let view : UIView = UIView()
        view.backgroundColor = .black
        view.alpha = 0.25
        return view
    }()
}
