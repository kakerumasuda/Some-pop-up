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
        PopUpViewController.show(on: self)
    }
    
    // Arrow Pop をタップした時の操作
    @IBAction func arrowPopDidTapped(_ sender: UIButton) {
        print("arrowPopDidTapped")
        // 自作Storyboardがある場合
        let storyboard = UIStoryboard(name: "ArrowPop", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ArrowPop") as! ArrowPopViewController
        /* ない場合は初期化でOK
        let vc = ArrowPopViewController()
        */
        // モーダル表示スタイルをポップオーバーに指定
        vc.modalPresentationStyle = .popover
        // 内容のサイズを指定
        vc.preferredContentSize = CGSize(width: 200, height: 100)
        // アンカービューを指定
        vc.popoverPresentationController?.sourceView = sender
        // アンカー領域を指定
        vc.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint.zero, size: sender.bounds.size)
        // 矢印の方向を指定
        vc.popoverPresentationController?.permittedArrowDirections = .any
        // デリゲートを設定
        vc.popoverPresentationController?.delegate = self
        // 吹き出しを表示
        present(vc, animated: true, completion: nil)
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
}

// ArrowPopのためのextension
extension ViewController: UIPopoverPresentationControllerDelegate {
    // デフォルトの代わりにnoneを返すことで、iPhoneでもpopover表示ができるように
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    // ArrowPopの外をタップしたら閉じるべきかどうかを指定できる（吹き出し内のボタンで閉じたい場合に利用）
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}
