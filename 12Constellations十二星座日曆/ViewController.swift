//
//  ViewController.swift
//  12Constellations十二星座日曆
//
//  Created by Rose on 2021/6/7.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weekSegment: UISegmentedControl!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearSwitch: UISwitch!
    @IBOutlet weak var constellationPicker: UIPickerView!
    //農曆
    @IBOutlet weak var lunarLabel: UILabel!
    //星座圖
    @IBOutlet weak var zodiacImageView: UIImageView!
    
    
    var constellations = [
        Constellation(name: "♈️牡羊座 Aries", startDate: "3/21", stopDate: "4/19", image: "牡羊"),
        Constellation(name: "♉️金牛座 Taurus", startDate: "04/20", stopDate: "05/20", image: "金牛"),
        Constellation(name: "♊️雙子座 Gemini", startDate: "05/21", stopDate: "06/20", image: "雙子"),
        Constellation(name: "♋️巨蟹座 Cancer", startDate: "06/21", stopDate: "07/22", image: "巨蟹"),
        Constellation(name: "♌️獅子座 Leo", startDate: "07/23", stopDate: "08/22", image: "獅子"),
        Constellation(name: "♍️處女座 Virgo", startDate: "08/23", stopDate: "09/22", image: "處女"),
        Constellation(name: "♎️天秤座 Libra", startDate: "09/23", stopDate: "10/22", image: "天秤"),
        Constellation(name: "♏️天蠍座 Scorpio", startDate: "10/23", stopDate: "11/21", image: "天蠍"),
        Constellation(name: "♐️射手座 Sagittarius", startDate: "11/22", stopDate: "12/21", image: "射手"),
        Constellation(name: "♑️摩羯座 Capricorn", startDate: "12/22", stopDate: "01/19", image: "摩羯"),
        Constellation(name: "♒️水瓶座 Aquarius", startDate: "01/20", stopDate: "02/18", image: "水瓶"),
        Constellation(name: "♓️雙魚座 Pisces", startDate: "02/19", stopDate: "03/20", image: "雙魚")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        // 根據日期調整顯示的星期、閏年和星座
        updateUI()
        lunarDate()
    }
    
    
    
    // 閏年判斷
    func isLeapYear(year: Int) -> Bool {
        if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0 && year % 3200 != 0) {
            return true
        } else {
            return false
        }
    }
    
    // updateUI
    func updateUI() {
        
        // 判斷 星期幾
        let dateComponent = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        //數字 1 是星期天，2 是星期一，其它以此類推。
        weekSegment.selectedSegmentIndex = dateComponent.weekday! - 1
        
        // 判斷閏年
        if let year = dateComponent.year{
            yearLabel.text = "\(year)"
            yearSwitch.isOn = isLeapYear(year: year)
        }
        
        // 判斷星座
        for (i, constellation) in constellations.enumerated() {
            if constellation.checkInterval(dateComponent: dateComponent) {
                constellationPicker.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        
    }
    
    // 委任 PickerView Delegate和DataSource的function，有幾個滾輪
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Picker View 每個滾輪有幾筆資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return constellations.count
    }
    
    
    // Picker View 內每筆資料的實際內容。
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return constellations[row].name
    }
    
    // 使用者選到什麼選項，就執行這個方法 --> 取得星座換圖
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 改變第一列時
        switch constellations[row].image {
        case "牡羊":
            zodiacImageView.image = UIImage(named: "牡羊")
        case "金牛":
            zodiacImageView.image = UIImage(named: "金牛")
        case "雙子":
            zodiacImageView.image = UIImage(named: "雙子")
        case "巨蟹":
            zodiacImageView.image = UIImage(named: "巨蟹")
        case "獅子":
            zodiacImageView.image = UIImage(named: "獅子")
        case "處女":
            zodiacImageView.image = UIImage(named: "處女")
        case "天秤":
            zodiacImageView.image = UIImage(named: "天秤")
        case "天蠍":
            zodiacImageView.image = UIImage(named: "天蠍")
        case "射手":
            zodiacImageView.image = UIImage(named: "射手")
        case "摩羯":
            zodiacImageView.image = UIImage(named: "摩羯")
        case "水瓶":
            zodiacImageView.image = UIImage(named: "水瓶")
        case "雙魚":
            zodiacImageView.image = UIImage(named: "雙魚")
        default:
            break
        }
        return constellations[row].image
        
        
    }
    
    // 農曆轉換
    func lunarDate() {
        let format = DateFormatter()
        format.dateStyle = .long
        format.timeStyle = .none
        format.calendar = Calendar(identifier: .chinese)
        format.locale = Locale(identifier: "zh_TW")
        let date = datePicker.date
        let dateString = format.string(from: date)
        lunarLabel.text = "農曆：" + dateString
        //print(dateString)
    }
    


}

