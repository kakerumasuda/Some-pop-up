//
//  SideMenuViewController.swift
//  some-pop-up
//
//  Created by Kakeru Masuda on 2021/04/25.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuView: UIView!
    var sideMenuOriginalCenter = CGPoint()
    @IBOutlet private weak var overlayView: UIView!
    var overlayViewDefaultAlpha: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // SideMenuViewの初期位置
        let position = self.sideMenuView.layer.position
        // SideMenuViewの位置をその横幅分動かす
        self.sideMenuView.layer.position.x = -self.sideMenuView.frame.width
        // 表示アニメーション
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: { self.sideMenuView.layer.position.x = position.x },
            completion: nil
        )
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 非表示アニメーション
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseIn,
            animations: { self.sideMenuView.layer.position.x = -self.sideMenuView.frame.width },
            completion: { _ in
                self.dismiss(animated: true, completion: nil)
        })
    }

    static func show(on vc: UIViewController) {
        // 表示設定
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "SideMenu") as! SideMenuViewController
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.modalPresentationStyle = .overFullScreen
        vc.present(nextVC, animated: true, completion: nil)
    }

    private func initializeUI() {
        sideMenuOriginalCenter = sideMenuView.center
        overlayViewDefaultAlpha = overlayView.alpha

        addGestureRecognizer()
    }

    private func addGestureRecognizer() {
        // サイドメニューをスクロールで閉じる動作を追加
        sideMenuView.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action: #selector(slideClose(_:))
        ))
        // サイドメニュー以外をタップして閉じる動作を追加
        overlayView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(overlayTapped)
        ))
    }

    @objc private func slideClose(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }

        gestureRecognizer.isEnabled = true
        let translation = gestureRecognizer.translation(in: view.superview)
        if gestureRecognizer.state == .began {
            sideMenuOriginalCenter = view.center
        }

        if gestureRecognizer.state == .changed {
            if translation.x < -5 {
                let newCenter = CGPoint(x: sideMenuOriginalCenter.x + translation.x,
                                        y: sideMenuOriginalCenter.y )
                view.center = newCenter
                // 閉じた割合だけoverlayを明るくする
                let closeRate = view.frame.maxX / sideMenuView.frame.width
                overlayView.alpha = 0.4 * closeRate
                
            } else if abs(translation.x) < 5 && abs(translation.y) > 5 {
                // 横slideと無駄な操作を排除
                gestureRecognizer.isEnabled = false
                self.sideMenuView.center.x = self.sideMenuOriginalCenter.x
            }
        }

        if gestureRecognizer.state == .ended {
            /*
             閾値設定: 画面の半分を過ぎたところでSlideを止めると閉じるように設定する
             */
            let threshold = self.view.center.x
            if view.frame.maxX < threshold {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(
                    withDuration: 0.2,
                    animations: {
                        self.sideMenuView.center.x = self.sideMenuOriginalCenter.x
                        self.overlayView.alpha = self.overlayViewDefaultAlpha
                })
            }
        }
    }

    // 陰影部分のtapで閉じる仕様追加
    @objc private func overlayTapped() {
        dismiss(animated: true, completion: nil)
    }
}


