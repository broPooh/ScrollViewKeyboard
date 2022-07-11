//
//  TestViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/07/06.
//

import UIKit

class TestViewController: UIViewController {
    
    let barrierQueue = DispatchQueue(label: "bro", attributes: .concurrent)
    let user = Memolease(name: "bro")


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func changeName() {
        for name in ["hue", "jack", "day", "ios"] {
            barrierQueue.async {
                self.user.name = name
                print("name is : \(self.user.name)")
            }
        }
    }
    

}


class Memolease {
    let concurrentQueue = DispatchQueue(label: "broMemolease",
                                        attributes: .concurrent)
    
    private var _name: String
    var name: String {
        get {
            //읽기 - sync
            concurrentQueue.sync {
                return self._name
            }
        }
        set {
            //쓰기 - async
            concurrentQueue.async(flags: .barrier, execute: {
                self._name = newValue
            })
        }
    }

    init(name: String) {
        self._name = name
    }
}
