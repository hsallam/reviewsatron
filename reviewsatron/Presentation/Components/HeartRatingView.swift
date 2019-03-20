//
//  HeartRatingView.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 20.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

// A bit of a smartass solution :). Given the time constraints, it holds though. Beats using a third-party library and enough for the requirements of display only. If needed to be interactive, would be inadequate.
class HeartRatingView: UIView {
    @IBInspectable var value: Double = 0 {
        didSet {
            updateStars()
        }
    }
    
    @IBInspectable var maximumValue: Int = 0 {
        didSet {
            guard maximumValue <= 20 else {
                maximumValue = 20
                return
            }
            updateStars()
        }
    }
    
    let label: UILabel
    
    required init?(coder aDecoder: NSCoder) {
        self.label = UILabel(frame: .zero)
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.textAlignment = .right
        self.addSubview(label)
    }
    
    private func updateStars() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.red];        
        let heartString = NSMutableAttributedString()
        
        for i in 0..<maximumValue {
            
            if(value >= Double(i+1)){
                // Full
                heartString.append(NSAttributedString(string: "\u{2665} ", attributes: attributes))
            }
            else if (value > Double(i)){
                // Half
                heartString.append(NSAttributedString(string: "\u{E1A0} ", attributes: attributes))
            }
            else{
                // Empty
                heartString.append(NSAttributedString(string: "\u{2661} ", attributes: attributes))
            }
        }
        
        label.attributedText = heartString
        label.font = UIFont(name: "SSPika", size: 15)
    }
}
