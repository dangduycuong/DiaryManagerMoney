//
//  BaseViewController.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 27/02/2024.
//  Copyright © 2024 Cuong. All rights reserved.
//

import UIKit
import Material

class BaseViewController: UIViewController {
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.backGround())
        return imageView
    }()
    
    func addBackButton() {
        view.layout(backImageView)
            .left(16)
            .centerY(titleLabel)
            .width(24)
            .height(24)
        backImageView.image = R.image.icons8Back()?.withRenderingMode(.alwaysTemplate)
        backImageView.tintColor = UIColor.black
        
        view.layout(backButton)
            .center(backImageView)
            .width(40)
            .height(44)
    }
    
    func addTitle(_ title: String?) {
        titleLabel.removeFromSuperview()
        view.layout(titleLabel)
            .topSafe()
            .centerX()
        titleLabel.text = title
    }
    
    func addBackGround() {
        view.layout(backGroundImageView)
            .top()
            .left()
            .bottom()
            .right()
    }
    
    func setupAddButton() {
        view.layout(addButton)
            .bottomSafe(16)
            .right(16)
            .width(40)
            .height(40)
        addButton.layer.cornerRadius = 20
        addButton.backgroundColor = UIColor.blue
        
        let imageView = UIImageView(image: R.image.add_to_photos_24px())
        
        addButton.layout(imageView)
            .center()
            .width(24)
            .height(24)
    }
    // MARK: - Actions
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
