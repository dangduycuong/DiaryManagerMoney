//
//  LoadingAnimationViewController.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 19/07/2023.
//  Copyright © 2023 Cuong. All rights reserved.
//

import UIKit
import Lottie

class LoadingAnimationViewController: UIViewController {
    
    private lazy var animationView: LottieAnimationView = {
        let jsonName = "animation_lk98ini8"
        let animation = LottieAnimation.named(jsonName)
        let view = LottieAnimationView(animation: animation)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0.5
        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerView)
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerView.widthAnchor.constraint(equalToConstant: view.bounds.size.width),
            centerView.heightAnchor.constraint(equalToConstant: view.bounds.size.width),
        ])
        centerView.backgroundColor = .clear
        animationView.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerView.centerYAnchor),
            animationView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 16),
            animationView.widthAnchor.constraint(equalToConstant: 44),
            animationView.heightAnchor.constraint(equalToConstant: 44)
        ])
        animationView.play()
    }
    
    deinit {
        print("---- object release")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
