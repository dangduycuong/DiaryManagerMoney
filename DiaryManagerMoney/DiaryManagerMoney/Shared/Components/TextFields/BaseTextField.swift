//
//  BaseTextField.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 27/02/2024.
//  Copyright © 2024 Cuong. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    //    override open var placeholder: String? {
    //        didSet {
    //            sharedInit()
    //        }
    //    }
    
    public var borderWidth: CGFloat = 1 {
        didSet {
            sharedInit()
        }
    }
    
    override var borderColor: UIColor? {
        didSet {
            sharedInit()
        }
    }
    
    public var placeholderColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            sharedInit()
        }
    }
    
    override var borderStyle: UITextField.BorderStyle {
        didSet {
            sharedInit()
        }
    }
    
    var isPlaceholderCenterAligment: Bool = false {
        didSet {
            sharedInit()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        //        if rightImage != nil {
        //            return bounds.inset(by: paddingWithRightImage)
        //        }
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        //        if rightImage != nil {
        //            return bounds.inset(by: paddingWithRightImage)
        //        }
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                updateDeactivatedView()
            } else {
                updateDefaultView()
            }
            //            updateView()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        borderStyle = .none
        invalidateIntrinsicContentSize()
    }
    
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: 48 + 15)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
    func sharedInit() {
        updateBorder()
        updateText()
        updatePlaceholder()
    }
    
    func updateFocusView() {
        //        self.borderColor = UIColor.greenE5
        //        self.tintColor = UIColor.white
        //        self.textColor = UIColor.white
        //        backgroundColor = UIColor.purpleB4
    }
    
    func updateDefaultView() {
        //        self.borderColor = UIColor.greenE5
        //        self.tintColor = UIColor.white
        //        self.textColor = UIColor.white
        //        //        self.backgroundColor = (self.text?.isEmpty ?? true) ? .primary12 : .secondary16
        backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }
    
    func updateSuccessView() {
        //        self.borderColor = UIColor.greenE5
        //        self.tintColor = UIColor.white
        //        self.textColor = UIColor.white
        //        self.backgroundColor = UIColor.purpleB4
    }
    
    func updateErrorView() {
        //        self.borderColor = UIColor.greenE5
        //        self.tintColor = UIColor.white
        //        self.textColor = UIColor.white
        //        self.backgroundColor = UIColor.purpleB4
    }
    
    func updateDeactivatedView() {
        //        self.borderColor = UIColor.greenE5
        //        self.tintColor = UIColor.white
        //        self.textColor = UIColor.white
        //        self.backgroundColor = UIColor.purpleB4
    }
    
    public func clearTextField() {
        self.text = ""
    }
    
    func updateBorder() {
        //        self.layer.cornerRadius = cornerRadius
        //        self.layer.borderWidth = borderWidth
        //        self.layer.borderColor = borderColor == nil ? UIColor.greenE5.cgColor : borderColor?.cgColor
        //        self.backgroundColor = UIColor.purpleB4
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEndOnExit)
    }
    
    func updateText() {
        //        self.tintColor = .white
        //        self.textColor = .white
        //        self.textAlignment =  isPlaceholderCenterAligment ? .center : .left
        //        self.font = R.font.interMedium(size: Session.shared.radius(15))
    }
    
    func updatePlaceholder() {
        //        if let placeholder = placeholder {
        //            let centeredParagraphStyle = NSMutableParagraphStyle()
        //            centeredParagraphStyle.alignment = isPlaceholderCenterAligment ? .center : .left
        //            let attributes: [NSAttributedString.Key: Any] = [
        //                .foregroundColor: UIColor.white.withAlphaComponent(0.5),
        //                .font: R.font.interMedium(size: Session.shared.fontSize(15)) as Any,
        //                .paragraphStyle: centeredParagraphStyle
        //            ]
        //            attributedPlaceholder = NSAttributedString(
        //                string: placeholder,
        //                attributes: attributes
        //            )
        //        }
    }
    
    // MARK: Override - UITexfieldDelegate
    
    @objc func textFieldDidBeginEditing() {
        //        updateFocusView()
    }
    
    @objc func textFieldDidEndEditing() {
        //        updateDefaultView()
    }
    
    @objc func textFieldShouldReturn() {
        self.resignFirstResponder()
    }
}
