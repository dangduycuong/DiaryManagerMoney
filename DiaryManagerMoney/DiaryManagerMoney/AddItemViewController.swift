//
//  ViewController.swift
//  DiaryManagerMoney
//
//  Created by Cuong on 4/28/19.
//  Copyright © 2019 Cuong. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var itemEntryTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        itemEntryTextView.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.blue
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ button: UIButton) {
        guard let enteredText =  itemEntryTextView.text else {
            return
        }
        
        if enteredText.isEmpty || itemEntryTextView.text == "Hôm nay có gì?" {
            print("No Data")
            
            let alert = UIAlertController(title: "Hãy viết gì đó", message: "Bạn chưa nhập nội dung gì.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy | h:mm a"
            let currentDate = formatter.string(from: date)
            
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            let currentTime = timeFormatter.string(from: date)
            
            guard let entryText = itemEntryTextView?.text else {
                return
            }
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Item(context: context)
            
            newEntry.title = entryText
            newEntry.date = currentDate 
            newEntry.time = currentTime
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}

