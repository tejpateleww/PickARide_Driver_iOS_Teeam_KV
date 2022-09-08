//
//  WithdrawHistoryCell.swift
//  PickaRideDriver
//
//  Created by Gaurang on 02/09/22.
//

import UIKit

class WithdrawHistoryCell: UITableViewCell {
    
    static let cellId = "withdraw_cell"

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: themeLabel!
    @IBOutlet weak var dateLabel: themeLabel!
    @IBOutlet weak var amountLabel: themeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func config(_ info: WithdrawInfo) {
        iconImageView.image = UIImage(named: info.status == "1" ? "Approved" : "Pending")
        messageLabel.text = info.status == "1" ? "Approved" : "Pending"
        var array: [String] = []
        let dateStr = info.status == "1" ? info.approveDate : info.requestDate
        if let date = DateFormatInputType.ddMMyyyy.getDate(from: dateStr ?? "") {
            array.append(DateFormatOutputType.onlyDate.getString(from: date))
        }
        array.append("#\(info.id)")
        dateLabel.text = array.joined(separator: " · ")
        amountLabel.text = info.amount?.toCurrencyString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func registerNib(to tableView: UITableView){
        let nib = UINib(nibName: WithdrawHistoryCell.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
}
