//
//  ViewController.swift
//  TableViewController
//
//  Created by julien brandin on 02/06/2017.
//  Copyright © 2017 julien brandin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias myDico = Dictionary<String,Any>
typealias myArray = Array<myDico>

/*
class myRequest: Mappable {
    var status: String
    var items = Array<myItem>()
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        status <- map["status"]
        items <- map["items"]
    }
}

class myItem: Mappable {
    var title: String
    var content: String
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        title <- map["title"]
        content <- map["description"]
    }
    
}
*/


class MyRequest: Mappable {
    var status: String!
    var items: Array<MyItem>!
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        items <- map["items"]
    }
}

class MyItem: Mappable{
    var title: String!
    var content: String!
    var author: String!
    var date: String!
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
        author <- map["author"]
        date <- map["pubDate"]
    }
}

class TableViewController: UITableViewController {
    
    //add label
    var text:String = "Default"
    
    var list = [AnyObject]()

    /*
    let listCourse : [String] = ["Banabne",
                                 "Chocolat",
                                 "Ramen",
                                 "Coca",
                                 "Dentifrice",
                                 "Lait"]
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        myLabel.text = text
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
        
        Alamofire.request("https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.reddit.com%2Fr%2Fgifs.rss").responseJSON{ response in
            
            guard let dict = response.value as? myDico else {
                return
            }
            
            if let innerDict = dict["items"]{
                self.list = innerDict as! [AnyObject]
                self.tableView.reloadData()
            }
            
            /*
                if let dict = response.value as? Dictionary<String,AnyObject>{
                    if let innerDict = dict["items"]{
                        self.list = innerDict as! [AnyObject]
                        self.tableView.reloadData()
                    }
                }
             */
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor.blue //Change background color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1 //change to change the number of section
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return section == 1 ? 3 : 5
        //return 3
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print(indexPath)
        //print(indexPath)

        
        //let toto = "macellule-" + String(indexPath.section + 1)
        //let toto = "macellule-\(indexPath.section+1)"

        let identifier = "macellule-1"
//        let identifier = indexPath.section == 0 ? "macellule-1" : "macellule-2"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath )
        
        
        guard let myCell = cell as? MyTableViewCell else {
            return  UITableViewCell()
        }
        
        myCell.configure(list[indexPath.row]["title"] as! String)
        
        /*
        //permet de savoir si myCell est du type MyTableViewCell
        if let myCell = cell as? MyTableViewCell {
            //myCell.myLabel.text = listCourse[indexPath.row]
            myCell.configure(list[indexPath.row]["title"] as! String)
        }
        */
        
        //OU
//        if cell is MyTableViewCell
        
        return cell
    }
   
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.dese
        
        print("Selected row: \(indexPath.row)")
     
        let text : String = self.list[indexPath.row] as! String
        
        
//        let ctr: UIViewController = UIViewController()
//        ctr.view.backgroundColor = UIColor.red
//        self.present(ctr, animated: true) {
//
//            
//            
//            let btn = UIButton(type: .custom) as UIButton
//            //btn.backgroundColor = .blue
//            btn.setTitle("Close", for: .normal)
//            btn.frame = CGRect(x: 150, y: 200, width: 100, height: 50)
//            
//            btn.addTarget(self, action: #selector(self.close(sender:)), for: .touchUpInside)
//            
////            btn.addTarget(self, action: #selector(clickMe), for: .touchUpInside)
//            ctr.view.addSubview(btn)
//            
//            let label = UILabel()
//            label.textColor = .white
//            label.text = text
//            label.frame = CGRect(x: 175, y: 100, width: 100, height: 50)
//            ctr.view.addSubview(label)
//
//            
//            /*
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "someViewController")
//            */
//            
//            /*
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
//                self.dismiss(animated: true)
//            }
//             */
//            
//        }
        
    }
 */
    
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        guard let ctr = segue.destination as? ViewController,
            let cell = sender as? MyTableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) else {
                return
        }
        
        /*
        do {
            let attrStr = try NSAttributedString(
                data: "<b><i>text</i></b>".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            print(attrStr)
            //ctr.myLabel.attributedText = attrStr
        } catch let error {
        }
        */

        ctr.text = self.list[indexPath.row]["description"] as! String
        ctr.author = self.list[indexPath.row]["author"] as! String
        ctr.date = self.list[indexPath.row]["pubDate"] as! String
        
        print(ctr.text)
        
        /*
        if let ctr = segue.destination as? ViewController, let cell = sender as? MyTableViewCell, let indexPath = self.tableView.indexPath(for: cell){
            ctr.text = self.list[indexPath.row]["description"] as! String
        }
         */
    }
    
    func close(sender:UIButton!) {
//        print("Button Clicked")
        self.dismiss(animated: true)
    }
    
}


/*
 
 
 pod init
 add to target (podfile)
 pod install
 
 
 
 */

