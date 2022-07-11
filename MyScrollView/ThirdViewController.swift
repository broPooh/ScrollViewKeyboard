//
//  ThirdViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/07/01.
//

import UIKit

class ThirdViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ThirdViewController viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ThirdViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ThirdViewController viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ThirdViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ThirdViewController viewDidDisappear")
    }

}
