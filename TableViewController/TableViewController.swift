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


class MyRequest: Mappable {
    var status: String!
    var items: Array<MyItem>!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        items <- map["items"]
    }
}

class MyItem: Mappable{
    var title: String!
    var content: String!
    var date: String!
    var author: String!
    
    required init?(map: Map){
        
    }

    required init?(title: String, content: String, date: String, author: String){
        self.title = title
        self.content = content
        self.date = date
        self.author = author
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
        date <- map["pubDate"]
        author <- map["author"]
    }
}

class TableViewController: UITableViewController {

    @IBAction func rigthButton(_ sender: UIBarButtonItem) {
        print("hello")
    }
    
    var text:String = "Default"
    var list = [AnyObject]()
    
    var MyRequest: MyRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
    
        Alamofire.request("https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.reddit.com%2Fr%2Fgifs.rss").responseObject{ (response: DataResponse<MyRequest>) in
           
            self.MyRequest = response.result.value
            
            self.tableView.reloadData()
        }
        
        let barButton = UIBarButtonItem(title: "Hello", style: .done, target: self, action: #selector(buttonHasBennPressed))
        self.navigationItem.rightBarButtonItem = barButton
        
        let barButtonEdit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editAction))
        self.navigationItem.leftBarButtonItem = barButtonEdit
        
    }
    
    func editAction(){
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    func buttonHasBennPressed(){
        print("hello")
        
        let alertController = UIAlertController(title: "My Alert", message: "Hello world", preferredStyle: .alert)
        
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            print("yo")
//        })
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Toto"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alertController] (_) in
            let textField = alertController?.textFields![0]
            
            let value = textField?.text ?? ""
            
            print("Hello : \(value)")
        }))
        
        let addRowAction = UIAlertAction(title: "Add row", style: .default, handler: { (action) in
            
            let item = MyItem(title: "Hello", content: "its me", date: "now", author : "Mario")
            
            self.MyRequest?.items.append(item!)
            
            let indexPath = IndexPath(row: (self.MyRequest?.items.count)! - 1, section: 0)
            
            self.tableView.insertRows(at: [indexPath], with: .fade)
            
        })
        
        alertController.addAction(addRowAction)
        
//        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MyRequest?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        var tmp = self.MyRequest?.items[sourceIndexPath.row]
        
        self.MyRequest?.items.remove(at: sourceIndexPath.row)
        self.MyRequest?.items.insert(tmp!, at: sourceIndexPath.row)
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            
            self.MyRequest?.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            
        }
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier = "macellule-1"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath )
        
        guard let myCell = cell as? MyTableViewCell else {
            return  UITableViewCell()
        }
        
//        myCell.configure(list[indexPath.row]["title"] as! String)
        
        myCell.configure((MyRequest?.items[indexPath.row].title)!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let ctr = segue.destination as? ViewController,
            let cell = sender as? MyTableViewCell,
            let indexPath = self.tableView.indexPath(for: cell) else {
                return
        }
        
//        ctr.text = self.list[indexPath.row]["description"] as! String
        
        ctr.text = (self.MyRequest?.items[indexPath.row].content)!
        ctr.date = (self.MyRequest?.items[indexPath.row].date)!
        ctr.author = (self.MyRequest?.items[indexPath.row].author)!
    
        
    }

}

