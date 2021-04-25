//
//  ViewController.swift
//  some-pop-up
//
//  Created by Kakeru Masuda on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sideMenuDidTapped(_ sender: UIButton) {
        print("sideMenuDidTapped")
    }
    
    @IBAction func bottomSheetDidTapped(_ sender: UIButton) {
        print("bottomSheetDidTapped")
    }
    
    @IBAction func popUpDidTapped(_ sender: UIButton) {
        print("popUpDidTapped")
    }
    
    @IBAction func arrowPopDidTapped(_ sender: UIButton) {
        print("arrowPopDidTapped")
    }
}

