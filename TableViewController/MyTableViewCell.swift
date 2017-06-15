//
//  MyTableViewCell.swift
//  TableViewController
//
//  Created by julien brandin on 02/06/2017.
//  Copyright © 2017 julien brandin. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
 
    @IBOutlet weak var myLabel: UILabel!
    
    func configure (_ text: String){
        self.myLabel.text = text
    }
    
}
