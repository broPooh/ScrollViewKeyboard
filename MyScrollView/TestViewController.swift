//
//  TestViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/09/15.
//

import UIKit
import IQKeyboardManagerSwift

class TestViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var keyboardHeight: CGFloat?
    var keyboardIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textViewConfigure()
        
        IQKeyboardManager.shared.enable = true
        //addNotification()
    }
    
    func textViewConfigure() {
        textView.isScrollEnabled = false
    }
    

}

extension TestViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        //calculateKeyboardHeight()
        //IQKeyboardManager.shared.reloadLayoutIfNeeded()
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
    }

}
