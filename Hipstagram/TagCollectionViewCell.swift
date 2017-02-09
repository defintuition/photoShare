//
//  TagCollectionViewCell.swift
//  Hipstagram
//
//  Created by Amber Spadafora on 2/7/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(cellLabel)
        cellLabel.snp.makeConstraints({ (label) in
            label.centerX.equalTo(self.snp.centerX)
            label.centerY.equalTo(self.snp.centerY)
        })
    }
    
    
    lazy var cellLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
}
