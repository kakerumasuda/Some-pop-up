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

    // Side Menu をタップした時の操作
    @IBAction func sideMenuDidTapped(_ sender: UIButton) {
        print("sideMenuDidTapped")
        SideMenuViewController.show(on: self)
    }
    
    // Bottom Sheet をタップした時の操作
    @IBAction func bottomSheetDidTapped(_ sender: UIButton) {
        print("bottomSheetDidTapped")
        BottomSheetViewController.show(on: self)
    }
    
    // Pop Up をタップした時の操作
    @IBAction func popUpDidTapped(_ sender: UIButton) {
        print("popUpDidTapped")
    }
    
    // Arrow Pop をタップした時の操作
    @IBAction func arrowPopDidTapped(_ sender: UIButton) {
        print("arrowPopDidTapped")
    }
    // Alert をタップした時の操作
    @IBAction func alertDidTapped(_ sender: UIButton) {
        print("alertDidTapped")
        let alert = UIAlertController(title: "Title", message: "MESSAGE IS HERE.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK")
            self.dismiss(animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Custom Alert をタップした時の操作
    @IBAction func customAlertDidTapped(_ sender: UIButton) {
        print("customAlertDidTapped")
    }
    
    // ActionSheet をタップした時の操作
    @IBAction func actionSheetDidTapped(_ sender: UIButton) {
        print("actionSheetDidTapped")
        let actionSheet = UIAlertController(title: "Title", message: "MESSAGE IS HERE.", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK")
            self.dismiss(animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "削除", style: .destructive, handler: { _ in
            print("削除")
            self.dismiss(animated: true, completion: nil)
        })
        
        actionSheet.addAction(ok)
        actionSheet.addAction(cancel)
        actionSheet.addAction(delete)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // Custom ActionSheet をタップした時の操作
    @IBAction func customActionSheetDidTapped(_ sender: UIButton) {
        print("customActionSheetDidTapped")
    }
}

