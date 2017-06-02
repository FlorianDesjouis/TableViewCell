//
//  ViewController.swift
//  TabViewController
//
//  Created by SUP'Internet 13 on 02/06/2017.
//  Copyright © 2017 SUP'Internet 13. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberCell: Int = 0;
        if(section == 0){
           numberCell = 3
        } else if(section == 1){
            numberCell = 5
        }
        return numberCell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cellule at\(indexPath.row)")
        var cell: UITableViewCell = UITableViewCell();
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "maCellule-1", for: indexPath)
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "maCellule-2", for: indexPath)

        }
        return cell
    }
}
