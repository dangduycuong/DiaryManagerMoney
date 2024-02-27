//
//  DiaryDetailViewController.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 27/02/2024.
//  Copyright © 2024 Cuong. All rights reserved.
//

import UIKit

class DiaryDetailViewController: BaseViewController {
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lưu Lại", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        textField.font = UIFont.boldSystemFont(ofSize: 21)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Nhập tiêu đề"
        return textField
    }()
    
    private lazy var moneyTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 21)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.placeholder = "Nhập số tiền"
        return textField
    }()
    
    private lazy var dateTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 21)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Chọn thời gian"
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
    }()
    
    private var money: Int64 = 0
    private var date: Date = Date.now
    var diaryModel: DiaryModel?
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
        
    }
    
    private func prepareForViewController() {
        addBackGround()
        addTitle(diaryModel?.title ?? "Thêm dữ liệu")
        
        addBackButton()
        
        view.layout(titleTextField)
            .below(titleLabel, 16)
            .left(16)
            .right(16)
            .height(40)
        
        view.layout(moneyTextField)
            .below(titleTextField, 16)
            .left(16)
            .right(16)
            .height(40)
        
        view.layout(dateTextField)
            .below(moneyTextField, 16)
            .left(16)
            .right(16)
            .height(40)
        
        view.layout(saveButton)
            .centerX()
            .bottomSafe(16)
            .width(150)
            .height(40)
        
        saveButton.backgroundColor = UIColor.blue
        
        if let diaryModel = diaryModel {
            titleTextField.text = diaryModel.title
            moneyTextField.text = "\(diaryModel.money)"
            
            let value = moneyTextField.text ?? ""
            let number = value.replacingOccurrences(of: ",", with: "").toInt()
            money = Int64(number)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, HH:mm:ss d MMMM, yyyy"
            dateFormatter.locale = Locale(identifier: "vi_VN")
            if let date = diaryModel.date {
                self.date = date
                dateTextField.text = dateFormatter.string(from: date)
            }
        }
    }
    
    private func setupUI() {
        datePicker.backgroundColor = .white
        datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        let datePickerView = UIDatePicker()
        datePickerView.preferredDatePickerStyle = .inline
        datePickerView.datePickerMode = .date
        datePickerView.locale = Locale(identifier: "vi_VN")
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        dateTextField.inputView = datePickerView
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, HH:mm:ss d MMMM, yyyy"
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateTextField.text = dateFormatter.string(from: sender.date)
        self.date = sender.date
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTappedShowDate(_ sender: UIButton) {
        datePicker.isHidden = false
        view.endEditing(true)
    }
    
    @IBAction func onTappedScreen(_ sender: UIButton) {
        view.endEditing(true)
        datePicker.isHidden = true
    }
    
    @IBAction func saveButtonTapped(_ button: UIButton) {
        guard let title = titleTextField.text else { return }
        
        if title.isEmpty {
            print("No Data")
            
            let alert = UIAlertController(title: "Hãy viết gì đó", message: "Bạn chưa nhập nội dung gì.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if let diaryModel = diaryModel {
                diaryModel.title = title
                diaryModel.money = money
                diaryModel.date = date
                do {
                    try context.save()
                } catch {
                    print("---- error", error)
                }
                navigationController?.popViewController(animated: true)
                return
            }
            let newEntry = DiaryModel(context: context)
            
            newEntry.title = title
            newEntry.money = money
            newEntry.date = date
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    
    @IBAction func onTappedOverScreen(_ sender: UITapGestureRecognizer) {
        //        datePicker.isHidden = true
    }
    
}

extension DiaryDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == titleTextField {
            return true
        }
        // I try this one
        if string == "0" {
            if textField.text!.count == 0 {
                return false
            }
        }
        
        // i also try to change the "textField" into "textPhoneNumber"
        if string == "0" {
            if moneyTextField.text!.count == 0 {
                return false
            }
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")                    // Adapt to your case
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.maximumFractionDigits = 6
        formatter.decimalSeparator = "."                                  // Adapt to your case
        formatter.groupingSeparator = ","                                 // Adapt to your case
        
        // The complete string if string were added at the end
        // Here we only insert figures at the end
        
        // Let us first remove extra groupingSeparator we may have introduced to find the number
        let completeString = textField.text!.replacingOccurrences(of: formatter.groupingSeparator, with: "") + string
        
        var backSpace = false
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                backSpace = true
            }
        }
        if string == "" && backSpace {           // backspace inserts nothing, but we need to accept it.
            return true
        }
        if string == "-" && textField.text! == "" {  // Accept leading minus
            return true
        }
        
        guard let value = Double(completeString) else { return false } // No double ; We do not insert
        
        let formattedNumber = formatter.string(from: NSNumber(value: value)) ?? ""
        textField.text = formattedNumber // We update the textField, adding typed character
        
        return string == formatter.decimalSeparator // No need to insert the typed char: we've done just above, unless we just typed separator
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moneyTextField.resignFirstResponder()
        let value = moneyTextField.text ?? ""
        let number = value.replacingOccurrences(of: ",", with: "").toInt()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == moneyTextField {
            let value = moneyTextField.text ?? ""
            let number = value.replacingOccurrences(of: ",", with: "").toInt()
            money = Int64(number)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        moneyTextField.resignFirstResponder()
        let value = moneyTextField.text ?? ""
        let number = value.replacingOccurrences(of: ",", with: "")
        money = Int64(number) ?? 0
    }
}
