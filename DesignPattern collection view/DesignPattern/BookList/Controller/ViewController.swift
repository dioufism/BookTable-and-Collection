//
//  ViewController.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/17/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

//trailing closure
import UIKit

class BookListViewController: UIViewController {
    
    @IBOutlet weak var bookListTableView: UITableView!
    var dataSource: [ItemInfo] = [] {
        didSet {
            self.bookListTableView.reloadData()
             // reload the table while the data is fetching
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books"
        getdata()
        
    }


    func getdata() {
        
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=coding")
    else{
    return
    }
        ServiceManager.manager.request(withUrl: url, compeltionHandler: { data, error in
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
            catch {print(error)}
            }
        })
    }
    
}
extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let SB = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = SB.instantiateViewController(identifier: "toDetail") as DetailViewController // instanciateInitialVc() >> check it out
        detailVC.itemInfo = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController( detailVC, animated: true )
        
        
        
    }
}
extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableTableViewCell", for: indexPath) as? ListTableTableViewCell, let volumeInfo = item.volumeInfo
        else {
            fatalError("unable to dequeue the cell")
        }
        cell.configureCell(with: volumeInfo)
        return cell
    }
    
}

