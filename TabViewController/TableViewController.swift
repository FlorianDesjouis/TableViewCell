//
//  ViewController.swift
//  TabViewController
//
//  Created by SUP'Internet 13 on 02/06/2017.
//  Copyright © 2017 SUP'Internet 13. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let shopList: Array<String> = ["patate", "fromage", "pizza", "jambon", "pate", "beurre"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cellule at\(indexPath.row)")
        let cell = indexPath.section == 1 ? tableView.dequeueReusableCell(withIdentifier: "maCellule-2", for: indexPath) : tableView.dequeueReusableCell(withIdentifier: "maCellule-1", for: indexPath)
        if let myCell = cell as? MyTableViewCell {
            myCell.label.text = shopList[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let ctrl: UIViewController = UIViewController()
        ctrl.view.backgroundColor = UIColor.blue
        self.present(ctrl, animated: true){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                self.dismiss(animated: true)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: storyboard)
            }
        }
        
    }
}
