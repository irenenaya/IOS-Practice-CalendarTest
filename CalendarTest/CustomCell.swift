//
//  CustomCell.swift
//  CalendarTest
//
//  Created by Irene Naya on 10/5/17.
//  Copyright © 2017 OnkySoft. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CustomCell: JTAppleCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
