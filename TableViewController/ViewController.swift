//
//  ViewController.swift
//  TableViewController
//
//  Created by julien brandin on 07/06/2017.
//  Copyright © 2017 julien brandin. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    var text = "Default"
    var author = "Default"
    var date = "Default"
    
    //@IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myAuthor: UILabel!
    
    //@IBAction func dimiss(_ sender: Any) {
    //    self.dismiss(animated: true, completion: nil)
    //}
    override func viewDidLoad() {
        
        do {
            let attrStr = try NSAttributedString(
                data: self.text.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            print(attrStr)
            //ctr.myLabel.attributedText = attrStr
            myLabel.attributedText = attrStr
        } catch let error {
        }
        
        printWithHtml(text: self.text, on: myLabel)
        printWithHtml(text: self.author, on: myAuthor)
        printWithHtml(text: self.date, on: myDate)
        
//        myLabel.text = self.text
        //myAuthor.text = self.author
        //myDate.text = self.date
    }
    
    
    func printWithHtml(text: String, on: UILabel){
        do {
            let attrStr = try NSAttributedString(
                data: text.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            print(attrStr)
            //ctr.myLabel.attributedText = attrStr
            //myLabel.attributedText = attrStr
            on.attributedText = attrStr
        } catch let error {
            return
        }
    }
    
    
}

