//
//  DetailViewController.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/22/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var itemInfo: ItemInfo?
    var image: ImageLinks?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var bookImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
   
}

extension DetailViewController {
    
    func setupUI() {
        // correct width and height
        bookImage.layer.cornerRadius = self.bookImage.bounds.height/2
        bookImage.layer.borderColor = UIColor.lightGray.cgColor
        bookImage.layer.borderWidth = 1.0
        bookImage.backgroundColor = .magenta
        if let item = itemInfo, let volume = item.volumeInfo {
            titleLabel.text = volume.title ?? ""
            subtitle.text = volume.subTitle
            author.text =  volume.authors?.joined() ?? ""
            publisher.text = volume.publisher
            descriptionLabel.text = volume.description
            
            if let urlString = volume.imageLinks?.smallThumbnail, let url = URL(string:urlString)
            {
                bookImage.downloadImage(url: url)
            }
        }
    }
    
}

extension UIImageView { // extension of the imageview so that we can directly s
    func downloadImage (url: URL) { //function that will download the image from the API
        DispatchQueue.global().async { //run downloading thread in a background thread
            do {
                let dataObj =  try Data(contentsOf: url) //Using data structs
                let image = UIImage(data: dataObj)
                DispatchQueue.main.async {
                    //makes image equal to the image from the url
                    self.image = image
                }
            }
            catch {print(error)}
        }
    }
    
}

