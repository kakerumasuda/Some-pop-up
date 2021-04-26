//
//  PopUpViewController.swift
//  some-pop-up
//
//  Created by Kakeru Masuda on 2021/04/25.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet private weak var PopUpView: UIView!
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var cancelImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
    }

    static func show(on vc: UIViewController) {
        // 表示設定
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "PopUp") as! PopUpViewController
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .overFullScreen
        vc.present(nextVC, animated: true, completion: nil)
    }

    private func initializeUI() {
        cancelImageView.image = UIImage(systemName: "xmark")
        addGestureRecognizer()
    }

    private func addGestureRecognizer() {
        // ×ボタン押した時の動作を追加
        cancelImageView.isUserInteractionEnabled = true
        cancelImageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(Xtapped))
        )
        
        // Pop Up以外をタップして閉じる動作を追加
        overlayView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(overlayTapped)
        ))
    }

    @objc private func Xtapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func overlayTapped() {
        dismiss(animated: true, completion: nil)
    }
}

