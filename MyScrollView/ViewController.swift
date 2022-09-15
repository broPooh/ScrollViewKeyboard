//
//  ViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/06/24.
//

import UIKit
import NotificationCenter
import IQKeyboardManagerSwift

class ViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var textView: UITextView!
    
    var keyboardHeight: CGFloat?
    var keyboardIsVisible = false

    @IBOutlet weak var textViewBottomConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollview.keyboardDismissMode = .onDrag
        
        textView.isScrollEnabled = false
        textView.delegate = self
        
        //textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        print("작동중?")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(keyboard:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(keyboard:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    @objc func keyboardWillShowNotification(keyboard: NSNotification){
        guard let keyboardFrameBegin = keyboard.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrameBeginRect = keyboardFrameBegin.cgRectValue
        
        //let userInfo = keyboard.userInfo
        //let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        keyboardHeight = keyboardFrameBeginRect.height

        calculateKeyboardHeight()
    }
    
    func animateUI(_ scrollValue: CGFloat) {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.view.frame.origin.y -= scrollValue
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    @objc func keyboardWillHideNotification(keyboard: NSNotification){
        self.keyboardIsVisible = false
        self.view.frame.origin.y = 0
        self.view.layoutIfNeeded()
        //animateUI(0)
    }
    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        self.textView.resignFirstResponder()
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    
    func calculateKeyboardHeight() {
        guard let keyboardHeight = keyboardHeight else { return }
        //텍스트뷰에서 선택한 텍스트까지의 사각형 크기
        let caret = textView.caretRect(for: textView.selectedTextRange!.start)
        
        
        //텍스트뷰의 전체 높이에서 선택한 텍스트의 길이를 빼고 남은 공간
        let size = textView.bounds.size.height - caret.origin.y
        print(size)
                            
        if size < keyboardHeight {
            print("작다")
            
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight
            self.view.layoutIfNeeded()
            //animateUI(keyboardHeight)
            
            
            //textView.scrollRectToVisible(caret, animated: true)
            //scrollview.scrollToBottom()
            
        } else {
            print("크다")
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
            //animateUI(0)
            
        }
    }
    
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.frame.origin.y = 0
        self.view.layoutIfNeeded()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        calculateKeyboardHeight()
        //IQKeyboardManager.shared.reloadLayoutIfNeeded()
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
        print(bottomOffset)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
