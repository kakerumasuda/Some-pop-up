//
//  BottomSheetViewController.swift
//  some-pop-up
//
//  Created by Kakeru Masuda on 2021/04/25.
//

import UIKit

class BottomSheetViewController: UIViewController {

        @IBOutlet weak var bottomSheetView: UIView!
        var bottomSheetOriginalCenter = CGPoint()
        @IBOutlet private weak var overlayView: UIView!
        var overlayViewDefaultAlpha: CGFloat = 0

        override func viewDidLoad() {
            super.viewDidLoad()

            initializeUI()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // bottomSheetViewの初期位置
            let position = self.bottomSheetView.layer.position
            // bottomSheetViewの位置をその縦幅分動かす
            self.bottomSheetView.layer.position.y += self.bottomSheetView.frame.height
            // 表示アニメーション
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseOut,
                animations: { self.bottomSheetView.layer.position.y = position.y },
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
                animations: { self.bottomSheetView.layer.position.y += self.bottomSheetView.frame.height },
                completion: { _ in
                    self.dismiss(animated: true, completion: nil)
            })
        }

        static func show(on vc: UIViewController) {
            // 表示設定
            let storyboard = UIStoryboard(name: "BottomSheet", bundle: nil)
            let nextVC = storyboard.instantiateViewController(identifier: "BottomSheet") as! BottomSheetViewController
            nextVC.modalTransitionStyle = .crossDissolve
            nextVC.modalPresentationStyle = .overFullScreen
            vc.present(nextVC, animated: true, completion: nil)
        }

        private func initializeUI() {
            bottomSheetOriginalCenter = bottomSheetView.center
            // Storyboardで設定されている値を代入
            overlayViewDefaultAlpha = overlayView.alpha

            addGestureRecognizer()
        }

        private func addGestureRecognizer() {
            // Bottom Sheetをスクロールで閉じる動作を追加
            bottomSheetView.addGestureRecognizer(UIPanGestureRecognizer(
                target: self,
                action: #selector(slideClose(_:))
            ))
            // Bottom Sheet以外をタップして閉じる動作を追加
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
                bottomSheetOriginalCenter = view.center
            }

            if gestureRecognizer.state == .changed {
                if translation.y > 5 {
                    let newCenter = CGPoint(x: bottomSheetOriginalCenter.x,
                                            y: bottomSheetOriginalCenter.y + translation.y)
                    view.center = newCenter
                    // 閉じた割合だけoverlayを明るくする
                    let height = bottomSheetView.frame.height
                    let closeRate = (height - translation.y) / height
                    overlayView.alpha = 0.4 * closeRate
                    
                } else if abs(translation.y) < 5 && abs(translation.x) > 5 {
                    // 縦slideと無駄な操作を排除
                    gestureRecognizer.isEnabled = false
                    self.bottomSheetView.center.y = self.bottomSheetOriginalCenter.y
                }
            }

            if gestureRecognizer.state == .ended {
                /*
                 閾値設定: 元viewの半分を過ぎたところでSlideを止めると閉じるように設定する
                 */
                let threshold = bottomSheetOriginalCenter.y
                if view.frame.minY > threshold {
                    dismiss(animated: true, completion: nil)
                } else {
                    UIView.animate(
                        withDuration: 0.2,
                        animations: {
                            self.bottomSheetView.center.y = self.bottomSheetOriginalCenter.y
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
