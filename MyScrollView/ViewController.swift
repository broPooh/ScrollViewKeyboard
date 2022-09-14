//
//  ViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/06/24.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var textView: UITextView!
    
    var keyboardHeight: CGFloat?

    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isScrollEnabled = false
        textView.delegate = self
        
        print("작동중?")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(keyboard:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(keyboard:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    @objc func keyboardWillShowNotification(keyboard: NSNotification){
        let userInfo = keyboard.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        keyboardHeight = keyboardFrame.height

       calculateKeyboardHeight()
    }
    
    @objc func keyboardWillHideNotification(keyboard: NSNotification){
        self.view.frame.origin.y = 0
    }
    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        self.textView.resignFirstResponder()
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    
    func calculateKeyboardHeight() {
        print("동작")
        let caret = textView.caretRect(for: textView.selectedTextRange!.start)
         print("\(caret.origin.y)")
        let keyboardTopBorder = textView.bounds.size.height - (keyboardHeight ?? 0)
        
        
        //caret.origin.y < keyboardTopBorder
        
        //남은 공간
        let size = textView.bounds.size.height - caret.origin.y
        print(size)
        
        guard let keyboardHeight = keyboardHeight else { return }
        if size < keyboardHeight {
            print("작다")
            textView.layoutIfNeeded()

            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight
            //textView.scrollRectToVisible(caret, animated: true)
            scrollview.scrollToBottom()
            
        } else {
            print("크 다")
            //textView.scrollRectToVisible(caret, animated: true)
            //self.view.frame.origin.y = 0
            //self.view.frame.origin.y -= keyboardHeight ?? 0
        }
    }
    
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.frame.origin.y = 0
    }
    
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        calculateKeyboardHeight()
//        return true
//    }
    
    func textViewDidChange(_ textView: UITextView) {
        calculateKeyboardHeight()
    }

}

public enum ScrollDirection {
    case top
    case center
    case bottom
}


public extension UIScrollView {

    func scroll(to direction: ScrollDirection) {

        DispatchQueue.main.async {
            switch direction {
            case .top:
                self.scrollToTop()
            case .center:
                self.scrollToCenter()
            case .bottom:
                self.scrollToBottom()
            }
        }
    }

    func scrollToTop() {
        setContentOffset(.zero, animated: true)
    }

    func scrollToCenter() {
        let centerOffset = CGPoint(x: 0, y: (contentSize.height - bounds.size.height) / 2)
        setContentOffset(centerOffset, animated: true)
    }

    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
