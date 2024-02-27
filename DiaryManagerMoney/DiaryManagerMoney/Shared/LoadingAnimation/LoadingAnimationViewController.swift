//
//  LoadingAnimationViewController.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 19/07/2023.
//  Copyright © 2023 Cuong. All rights reserved.
//

import UIKit
import Lottie
import Material

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
        view.layout(centerView)
            .center()
            .width(44)
            .height(44)
        
        centerView.layout(animationView)
            .top()
            .left()
            .bottom()
            .right()
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
