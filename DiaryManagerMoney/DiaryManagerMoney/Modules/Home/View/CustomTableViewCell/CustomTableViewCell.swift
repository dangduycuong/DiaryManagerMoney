//
//  CustomTableViewCell.swift
//  DiaryManagerMoney
//
//  Created by cuongdd on 27/02/2024.
//  Copyright © 2024 Cuong. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(title: String?, money: Int64?, date: Date?) {
        titleLabel.text = title
        moneyLabel.text = displayMoney(money ?? 0)
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY, HH:mm:ss"
            let string = dateFormatter.string(from: date)
            let timeStamp = "Add on \(string)"
            dateLabel.text = timeStamp
        }
    }
    
    func displayMoney(_ number: Int64) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")                    // Adapt to your case
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.maximumFractionDigits = 6
        formatter.decimalSeparator = "."                                  // Adapt to your case
        formatter.groupingSeparator = " "                                 // Adapt to your case
        
        // The complete string if string were added at the end
        // Here we only insert figures at the end
        
        // Let us first remove extra groupingSeparator we may have introduced to find the number
        let completeString = String(number)
        
        guard let value = Double(completeString) else { return "" } // No double ; We do not insert
        
        let formattedNumber = formatter.string(from: NSNumber(value: value)) ?? ""
        
        return formattedNumber
    }

}
