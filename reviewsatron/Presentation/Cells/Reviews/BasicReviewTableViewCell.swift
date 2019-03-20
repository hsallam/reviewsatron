//
//  BasicReviewTableViewCell.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

class BasicReviewTableViewCell: ReviewTableViewCell {
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var initialsCircleView: UIView!
    @IBOutlet weak var authorProfileImageView: UIImageView!
    @IBOutlet weak var ratingView: HeartRatingView!
    
    var reviewId: Int = 0
    
    func update(with review: Review) {
        reviewId = review.id
        authorNameLabel.text = review.reviewerName
        messageLabel.text = review.message
        initialsLabel.text = review.reviewerInitials.isEmpty ? "?" : review.reviewerInitials
        ratingView.value = Double(review.rating) ?? 0.0
        ratingView.maximumValue = 5
        if initialsCircleView.backgroundColor == .black { // Only change it once per the cell's lifetime
            initialsCircleView.backgroundColor = .random
        }
        
        if let profileImageUrl = review.reviewerProfilePhoto, let url = URL(string: profileImageUrl) {
            authorProfileImageView.alpha = 1.0
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, self.reviewId == review.id else { return }
                DispatchQueue.main.async() {
                    self.authorProfileImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        else {
            authorProfileImageView.alpha = 0.0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorNameLabel.text = nil
        messageLabel.text = nil
        initialsLabel.text = nil
        authorProfileImageView.image = nil
    }
}
