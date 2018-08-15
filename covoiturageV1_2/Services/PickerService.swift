//
//  PickerService.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/15/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import Foundation
class  PickerService {
   static let  instance  = PickerService()
    // fill the age table view
    func fillListAge() -> [String]{
        var list : [String] = [String]()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        var result = Int(formatter.string(from: date))
        result = result! - 18
        var j = 1950
        repeat {
            j += 1
            list.append(String(j))
        } while (j < result!)
        return list
    }

    //fill the hour tableView
    func fillListHour() -> [String]{
        var list : [String] = [String]()

        var j = 0
        repeat {
            if j < 10{
                list.append(String("0\(j)"))
            }else{
                list.append(String(j))
            }
            j += 1
        } while (j < 24)
        return list
    }
    //fill the minute tableview
    func fillListminute() -> [String]{
        var list : [String] = [String]()
        var j = 0
        repeat {
            if j == 0{
                list.append("00")
            }else{
                list.append(String(j))
            }
            j += 15
        } while (j < 60)
        return list
    }
}
