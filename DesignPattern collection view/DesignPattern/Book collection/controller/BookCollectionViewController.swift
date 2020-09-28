//
//  BookCollectionViewController.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/24/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

import UIKit

class BookCollectionViewController: UIViewController {
    @IBOutlet weak var bookCollection: UICollectionView!
    
    //MARK: -dataSource Array
    var dataSource: [ItemInfo] = [] {
        didSet {  
            self.bookCollection.reloadData() // reloading the data while fetching it so that it can b visible to us
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "collection book"
        getDataForCollection()
        // Do any additional setup after loading the view.
    }
    
// MARK: -Helper Functions
    func getDataForCollection()  {
        // provide URL to the API using the URL class
        guard let url =  URL(string: "https://www.googleapis.com/books/v1/volumes?q=coding" )
        else { return }
        
        //In the main queue
        ServiceManager.manager.request (withUrl: url) { data, error in
            
            DispatchQueue.main.async {
            guard let dataObj = data as? Data else {
                return
            }
            do {
            let responseObj = try JSONDecoder().decode(ApiResponse.self, from: dataObj)
                print(responseObj)
                self.dataSource =  responseObj.items ?? []
            //decode takes a struct that confirms to decodable protocol
            }
            catch { print(error) }
            }
        }
            
    }

}

//MARK:-Delegate Methods

// helps pick up interaction with the cells
extension BookCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bookCollection.deselectItem(at: indexPath, animated: true)
        
        let SB = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = SB.instantiateViewController(identifier: "toDetail") as DetailViewController // instanciateInitialVc() >> check it out
        detailVC.itemInfo = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController( detailVC, animated: true )
    }
}

//MARK: -DataSource Methods

extension BookCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let item =  self.dataSource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "BookListCollectionViewCell", for: indexPath) as? BookListCollectionViewCell, let volumeInfo = self.dataSource[indexPath.row].volumeInfo   else {
        fatalError("cannot dequeue cell")
        }
        cell.configureCollectionCell(with: volumeInfo )
        return cell
    }
    
  
}
//MARK: -FlowLayout Methods
// sets the margin and padding between each cell
extension BookCollectionViewController: UICollectionViewDelegateFlowLayout {}
