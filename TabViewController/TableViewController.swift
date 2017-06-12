//
//  ViewController.swift
//  TabViewController
//
//  Created by SUP'Internet 13 on 02/06/2017.
//  Copyright © 2017 SUP'Internet 13. All rights reserved.
//

import UIKit
import Alamofire

let url = "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.theguardian.com%2Finternational%2Frss"

class TableViewController: UITableViewController {
    
    var text: String = "default"
    
    var shopList: [[String: Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        
        Alamofire.request(url).responseJSON {(response) in if let serialized = response.value as? Dictionary<String, Any>,
            let items = serialized["items"] as? Array<Dictionary<String, Any>> {
            self.shopList = items
            self.tableView.reloadData()
            print("Data loaded items \(items.count)")
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cellule at\(indexPath.row)")
        let cell = indexPath.section == 1 ? tableView.dequeueReusableCell(withIdentifier: "maCellule-2", for: indexPath) : tableView.dequeueReusableCell(withIdentifier: "maCellule-1", for: indexPath)
        if let myCell = cell as? MyTableViewCell {
            myCell.label.text = shopList[indexPath.row]
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ctrl = segue.destination as? DetailViewController {
            if let cell = sender as? MyTableViewCell {
            if let indexPath = self.tableView.indexPath(for: cell) {
                if let list = self.shopList{
                    let item = shopList?[indexPath.row]
                    if let title = item?["title"] as! String? {
                        ctrl.text = title
                        }
                    }
                }
            }
        }
    }
}
