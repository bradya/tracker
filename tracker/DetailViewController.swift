//
//  DetailViewController.swift
//  tracker
//
//  Created by Brady Archambo on 9/2/14.
//  Copyright (c) 2014 Boa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
                            
    @IBOutlet weak var noteTextView: UITextView!
    let placeholder: String = "Type here..."

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let textView = self.noteTextView {
                let note: AnyObject! = detail.valueForKey("note")
                
                textView.text = note != nil ? note.description : ""
                textView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0)
                textView.scrollIndicatorInsets = UIEdgeInsetsMake(8, 0, 8, 0)
                textView.delegate = self
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.noteTextView.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func textViewDidChange(textView: UITextView) {
        if let detail: AnyObject = self.detailItem {
            detail.setValue(self.noteTextView.text, forKey: "note")
        }
    }
    
    func keyboardWillShow(note: NSNotification) {
        if let userInfo: NSDictionary = note.userInfo {
            if let frame: CGRect = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue() {
                var contentInsets: UIEdgeInsets = self.noteTextView.contentInset
                contentInsets.bottom = CGRectGetHeight(frame)
                
                self.noteTextView.contentInset = contentInsets
                self.noteTextView.scrollIndicatorInsets = contentInsets
            }
        }
    }
    
    func keyboardWillHide(note: NSNotification) {
        var contentInsets = self.noteTextView.contentInset
        contentInsets.bottom = 0.0;
        
        self.noteTextView.contentInset = contentInsets;
        self.noteTextView.scrollIndicatorInsets = contentInsets;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

