//
//  ServiceManager.swift
//  DesignPattern
//
//  Created by ousmane diouf on 9/17/20.
//  Copyright © 2020 Exa Data. All rights reserved.
//

/* guarante that one isntance of a class will be created
 *provides global access which means all properties and methods from this class can be accessed
 * allows to share common setting which means that variables can stay constant during the lifetime of the class from start of execution to end of execution
 *  cannot use delegate on a singleton
 */
// ADVANTAGES AND DISAVANTAGES OF SINGLETON

import Foundation

// we need to put restriction so that one instance of this class is created
//https://api.openweathermap.org/data/2.5/weather?id=4276614&appid=0f7e07a9d99396dcf15d793331c720b8
//try? will handle nil; try! will crash program will never excute catch block
class ServiceManager {
    
// step2 make a constant type property which is a common access point
    static let manager =  ServiceManager()
    
// step one make only one private init
    private init() {}
    
    //requires URL and completion handler will return result in a closure
    func request(withUrl url: URL,  compeltionHandler: @escaping (Any?, Error?) -> Void ) {
     URLSession.shared.dataTask(with: url) { (data, response, error) in // URLsession request the data from the server
            guard let data = data else {
                DispatchQueue.main.async {
                compeltionHandler(nil, error)
                    
                }
                return
            }
            do {
                //let jsonObj  =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                DispatchQueue.main.async {
                compeltionHandler(data, nil)
                }
            }
            catch let error { // can also use catch let error explicitly
                print(error)
                
            }
        }.resume()
    
    }
}


//UI elements are accessed in the main thread
