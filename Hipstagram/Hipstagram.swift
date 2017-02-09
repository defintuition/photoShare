//
//  Hipstagram.swift
//  Hipstagram
//
//  Created by Annie Tung on 2/7/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import Foundation
import UIKit

struct User {
    let name: String
    let uid: String
    let email: String
    let profileImage: String
    let imagePath: String
    let upvote: Bool
}

struct Image {
    let uid: String
    let date: String
    let categoryID: String
    let imagePath: String
    let upvote: Int
}

struct Category {
    let name: String
    let categoryID: String
}
