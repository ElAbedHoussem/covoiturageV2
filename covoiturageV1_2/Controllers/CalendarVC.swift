//
//  CalendarVC.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/10/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit
import EventKit
class CalendarVC: UIViewController ,  CalendarViewDataSource, CalendarViewDelegate {


    // MARK : KDCalendarDelegate

    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {

        print("Did Select: \(date) with \(events.count) events")
        for event in events {
            print("\t\"\(event)\" - Starting at:\(event)")
        }

    }

    func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {

        self.datePicker.setDate(date, animated: true)
    }


    func calendar(_ calendar: CalendarView, didLongPressDate date : Date) {

        let alert = UIAlertController(title: "Create New Event", message: "Message", preferredStyle: .alert)

        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Event Title"
        }

        let addEventAction = UIAlertAction(title: "Create", style: .default, handler: { (action) -> Void in
            let title = alert.textFields?.first?.text
            self.calendarView.addEvent(title!, date: date)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        alert.addAction(addEventAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)

    }




    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return false
    }

    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {

    }





    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var datePicker: UIDatePicker!


    override func viewDidLoad() {

        super.viewDidLoad()

        CalendarView.Style.cellShape                = .bevel(8.0)
        CalendarView.Style.cellColorDefault         = UIColor.clear
        CalendarView.Style.cellColorToday           = UIColor(red:1.00, green:0.84, blue:0.64, alpha:1.00)
        CalendarView.Style.cellSelectedBorderColor  = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.cellEventColor           = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.headerTextColor          = UIColor.white
        CalendarView.Style.cellTextColorDefault     = UIColor.white
        CalendarView.Style.cellTextColorToday       = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)

        CalendarView.Style.firstWeekday             = .monday

        calendarView.dataSource = self
        calendarView.delegate = self

        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true


        calendarView.backgroundColor = UIColor(red:0.31, green:0.44, blue:0.47, alpha:1.00)


    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        let today = Date()

        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1


        let tomorrow = self.calendarView.calendar.date(byAdding: tomorrowComponents, to: today)!
        self.calendarView.selectDate(tomorrow)


        /*
        self.calendarView.loadEvents() { error in
            if error != nil {
                let message = "The karmadust calender could not load system events. It is possibly a problem with permissions"
                let alert = UIAlertController(title: "Events Loading Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        */

        self.calendarView.setDisplayDate(today)
        self.datePicker.setDate(today, animated: false)

    }

    // MARK : KDCalendarDataSource

    func startDate() -> Date {

        var dateComponents = DateComponents()
        dateComponents.month = -3

        let today = Date()

        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!

        return threeMonthsAgo
    }

    func endDate() -> Date {

        var dateComponents = DateComponents()

        dateComponents.year = 2;
        let today = Date()

        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!

        return twoYearsFromNow

    }






    // MARK : Events

    @IBAction func onValueChange(_ picker : UIDatePicker) {
        self.calendarView.setDisplayDate(picker.date, animated: true)
    }

    @IBAction func goToPreviousMonth(_ sender: Any) {
        self.calendarView.goToPreviousMonth()
    }
    @IBAction func goToNextMonth(_ sender: Any) {
        self.calendarView.goToNextMonth()

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
