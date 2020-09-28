//
//  BookListCollectionViewCell.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/24/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

import UIKit

class BookListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookCell: UIView!
    @IBOutlet weak var bookImageCell: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: configure collection cell
    func configureCollectionCell(with itemInfo: VolumeInfo) {
        
        if let thumbNail = itemInfo.imageLinks?.smallThumbnail, let url = URL(string: thumbNail) {
            DispatchQueue.global().async {
                do {
                    //dowmnload the image from the url
                    let data = try Data(contentsOf: url)
                    //set the image to be equal to the downloaded image
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.bookImageCell.image = image
                    }
                }
                catch { print(error)}
            }
        }
    }
}
