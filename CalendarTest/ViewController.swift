//
//  ViewController.swift
//  CalendarTest
//
//  Created by Irene Naya on 10/5/17.
//  Copyright © 2017 OnkySoft. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    let formatter = DateFormatter()
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var currDate: UILabel!
    @IBOutlet weak var reminderView: UITableView!
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0x505a66)
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor(colorWithHexValue: 0x3e294b)
    let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        calendarView.scrollToDate(Date(), animateScroll : false)
        let idx = IndexPath(row: 8, section: 0)
        reminderView.scrollToRow(at: idx, at: .top, animated: false)
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        let today = formatter.string(from : Date())
        currDate.text = today
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleCellColor(cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else { return }
        formatter.dateFormat = "yyyy MM dd"
        let curr = formatter.string(from : cellState.date)
        let today = formatter.string(from : Date() )
        if cellState.isSelected {
            validCell.cellView.isHidden = false
            
        }
        else if curr == today {
           
            validCell.cellView.isHidden = false
            validCell.cellView.backgroundColor = UIColor.blue
        }
        else {
            validCell.cellView.isHidden = true
        }
    }
    
    func handleCellTextColor(view : JTAppleCell? , cellState : CellState) {
        guard let validCell = view as? CustomCell else { return }
        
        if cellState.isSelected {
            validCell.textLabel.textColor = selectedMonthColor
        }
        else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.textLabel.textColor = monthColor
            }
            else {
                validCell.textLabel.textColor = UIColor.gray
            }
        }
        
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)

    }

}

extension ViewController:  JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2017 12 31")
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
}

extension ViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell" , for: indexPath) as! CustomCell
        cell.textLabel.text = cellState.text
        
        handleCellColor(cell: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellColor(cell: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        formatter.dateFormat = "EEEE dd MMMM yyyy"
        let curr = formatter.string(from: date)
        currDate.text = curr
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellColor(cell: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        let txt = indexPath.row < 10 ? "0" + String(indexPath.row) : String(indexPath.row)
        cell.timeLabel.text = txt + ":00"
        if indexPath.row == 11 {
            cell.eventLabel.text = "Walkifaj Lucinda"
        }
        return cell
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green : CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha : alpha
        )
    }
}
