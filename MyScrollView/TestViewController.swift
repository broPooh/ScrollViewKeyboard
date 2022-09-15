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
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(keyboard:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(keyboard:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowNotification(keyboard: NSNotification){
        guard let keyboardFrameBegin = keyboard.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrameBeginRect = keyboardFrameBegin.cgRectValue

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
    
    
    
    func textViewConfigure() {
        textView.isScrollEnabled = false
    }
    
    func calculateKeyboardHeight() {
        guard let keyboardHeight = keyboardHeight else { return }
        //텍스트뷰에서 선택한 텍스트까지의 사각형 크기
        //끝을 선택하면 잘되는데 중간을 선택하면 범위 지정이 잘 안된다. 다른 접근이 필요한가.?
        let caret = textView.caretRect(for: textView.selectedTextRange!.start)
        
        
        //텍스트뷰의 전체 높이에서 선택한 텍스트의 길이를 빼고 남은 공간
        let size = textView.bounds.size.height - caret.origin.y
        print("origin: \(caret.origin.y)")
        print(size)
                            
        if size < keyboardHeight {
            print("작다")
            
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight
            self.view.layoutIfNeeded()

            textView.scrollRectToVisible(caret, animated: true)
            //scrollView.scrollToBottom()
            
        } else {
            print("크다")
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
        }
    }
    

}

extension TestViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.frame.origin.y = 0
        self.view.layoutIfNeeded()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //calculateKeyboardHeight()
        //IQKeyboardManager.shared.reloadLayoutIfNeeded()
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
    }

}
