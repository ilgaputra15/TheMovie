//
//  MovieViewCell.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit

class MovieViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
    }
    
    func setView(movie: HomeModel) {
        image.setImage(from: movie.posterURL)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }

}
