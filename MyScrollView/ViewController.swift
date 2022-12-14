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
//        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
//            self.view.frame.origin.y -= scrollValue
//            self.view.layoutIfNeeded()
//        }
//        animator.startAnimation()
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y -= scrollValue
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHideNotification(keyboard: NSNotification){
        self.keyboardIsVisible = false
        self.view.frame.origin.y = 0
        self.view.layoutIfNeeded()
        //animateUI(0)
    }
    

    @IBAction func buttonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    
    func calculateKeyboardHeight() {
        guard let keyboardHeight = keyboardHeight else { return }
        //?????????????????? ????????? ?????????????????? ????????? ??????
        //?????? ???????????? ???????????? ????????? ???????????? ?????? ????????? ??? ?????????. ?????? ????????? ????????????.?
        let caret = textView.caretRect(for: textView.selectedTextRange!.start)
        
        
        //??????????????? ?????? ???????????? ????????? ???????????? ????????? ?????? ?????? ??????
        let size = textView.bounds.size.height - caret.origin.y
        print("origin: \(caret.origin.y)")
        print(size)
                            
        if size < keyboardHeight {
            print("??????")
            
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight
            self.view.layoutIfNeeded()
            
            textView.scrollRectToVisible(caret, animated: true)
            //scrollview.scrollToBottom()
            
        } else {
            print("??????")
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
            textView.scrollRectToVisible(caret, animated: true)
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
