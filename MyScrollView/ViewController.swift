//
//  ViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/06/24.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var sharedValue = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        var a : Test = B.init()
        let b = B()
        
        let bes = UIView()
        bes.clipsToBounds = true
        bes.layer.masksToBounds = true

    }
    
    func changeTest() {
        DispatchQueue.global(qos: .background).async {
            print("background", Thread.current)
            var newValue = self.sharedValue
            print("background Before", newValue)
            newValue += 1
            self.sharedValue = newValue
            print("background after", self.sharedValue)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            print("userInitiated", Thread.current)
            var newValue = self.sharedValue
            print("userInitiated Before", newValue)
            newValue += 1
            self.sharedValue = newValue
            print("userInitiated after", self.sharedValue)
        }
    }



}

protocol Test {
    static var test: String { get set }
    func hi()
}

extension Test {
    func hi() {
        print("test")
    }
}

class A: Test {
    static var test: String = "ss"
    
}

class B: Test {
    static var test: String = "ss"
    
    func hi() {
        print("bb")
    }
}

class c {
    func extensionOverrideTest() {
        
    }
}

