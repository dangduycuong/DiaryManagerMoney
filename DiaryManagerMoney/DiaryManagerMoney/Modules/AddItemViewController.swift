//
//  ViewController.swift
//  DiaryManagerMoney
//
//  Created by Cuong on 4/28/19.
//  Copyright © 2019 Cuong. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var moneyTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var money: Int = 0
    private var date: Date = Date.now
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }
    
    private func setupUI() {
        datePicker.backgroundColor = .white
        datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        let datePickerView = UIDatePicker()
        datePickerView.preferredDatePickerStyle = .inline
        datePickerView.datePickerMode = .dateAndTime
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
    
    @IBAction func saveButton(_ button: UIButton) {
        guard let title =  titleTextField.text else { return }
        guard let money =  moneyTextField.text else { return }
        
        if title.isEmpty || money.isEmpty {
            print("No Data")
            
            let alert = UIAlertController(title: "Hãy viết gì đó", message: "Bạn chưa nhập nội dung gì.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Item(context: context)
            
            newEntry.title = title
            if let money = Double(money) {
                newEntry.money = money
            }
            
            newEntry.date = date
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onTappedOverScreen(_ sender: UITapGestureRecognizer) {
        //        datePicker.isHidden = true
    }
    
    
    
}

extension AddItemViewController: UITextFieldDelegate {
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
        print("---- value of money is ", number)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == moneyTextField {
            let value = moneyTextField.text ?? ""
            let number = value.replacingOccurrences(of: ",", with: "").toInt()
            print("---- value of money is ", number)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        moneyTextField.resignFirstResponder()
        let value = moneyTextField.text ?? ""
        let number = value.replacingOccurrences(of: ",", with: "").toInt()
        money = number
        print("---- value of money is ", number)
    }
}

extension String {
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}
