//
//  ListTableTableViewCell.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/18/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

import UIKit

class ListTableTableViewCell: UITableViewCell {
    
    //MARK: -OUTLETS
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var booktitle: UILabel!
    @IBOutlet weak var bookSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      self.bookImage.layer.cornerRadius = self.bookImage.bounds.height/2
       self.bookImage.layer.borderColor = UIColor.lightGray.cgColor
       self.bookImage.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - Cell Configuration
    func configureCell(with itemInfo: VolumeInfo) {
        self.booktitle.text = itemInfo.title
        self.bookSubtitle.text = itemInfo.subTitle
        self.bookSubtitle.isHidden = itemInfo.subTitle?.isEmpty ?? true
        
        if let thumbNail =  itemInfo.imageLinks?.smallThumbnail, let url = URL(string: thumbNail) {
        
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.bookImage.image = image
                    }
                  
                }
                catch {
                    print(error)
                }
            }
            
    }

}

}
// gets failable initializer therefore it might or might not get the data
//check the Data(contentsOf: URL) it is a synchronous method that is maknng the tableview lag
// global is still running in the background that is the reason why the images are being loaded
