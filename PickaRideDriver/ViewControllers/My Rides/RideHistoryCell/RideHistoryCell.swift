//
//  RideHistoryCell.swift
//  PickaRideDriver
//
//  Created by Gaurang on 19/09/22.
//

import UIKit

class RideHistoryCell: UITableViewCell {

    @IBOutlet weak var dateLabel: themeLabel!
    @IBOutlet weak var pickupAddressLabel: RideDetailLabel!
    @IBOutlet weak var destinationLabel: RideDetailLabel!
    @IBOutlet weak var nameLabel: RideDetailLabel!
    @IBOutlet weak var priceLabel: RideDetailLabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    static let cellId = "ride_history_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: highlighted ? 0.1 : 0.2) {
            self.transform = highlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
        }
    }
    
    func setValues(_ info: PastBookingResDatum, rideState: Int) {
        guard let bookingInfo = info.bookingInfo else {
            return
        }
        let bookingStatus = bookingInfo.status
       // let bookingType = bookingInfo.bookingType
        let acceptTime = Double(bookingInfo.acceptTime ?? "") ?? 0
        let bookingTime = Double(bookingInfo.bookingTime ?? "") ?? 0.0
        let pickupDateTime = Double(bookingInfo.pickupDateTime ?? "") ?? 0.0
        let timeStamp: TimeInterval = {
            if rideState == 0 {
                return acceptTime
            } else if rideState == 1{
                return bookingTime
            } else {
                return pickupDateTime
            }
        }()
        let date = Date(timeIntervalSince1970: timeStamp)
        let formatedDate = date.timeAgoSinceDate(isForNotification: false)
        dateLabel.text = formatedDate
        nameLabel.text = bookingInfo.vehicleName
        pickupAddressLabel.text = bookingInfo.pickupLocation
        destinationLabel.text = bookingInfo.dropoffLocation
        let amount: String = {
            if rideState == 0 {
                return bookingInfo.driverAmount ?? "0"
            } else {
                return bookingInfo.estimatedFare ?? "0"
            }
        }()
        priceLabel.text = amount.toCurrencyString()
        statusImageView.image = bookingStatus?.image
    }
    
}
