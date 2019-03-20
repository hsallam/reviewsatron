//
//  UIColor+Additions.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 20.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
