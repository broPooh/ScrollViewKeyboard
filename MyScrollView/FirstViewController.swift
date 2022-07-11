//
//  FirstViewController.swift
//  MyScrollView
//
//  Created by bro on 2022/07/01.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func buttonDidTapped(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FirstViewController viewDidLoad")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("FirstViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("FirstViewController viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("FirstViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("FirstViewController viewDidDisappear")
    }
    

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        //Tap 제스쳐를 인식했을 때 실행하고 싶은 코드를 작성
        view.endEditing(true)
        
    }
}
