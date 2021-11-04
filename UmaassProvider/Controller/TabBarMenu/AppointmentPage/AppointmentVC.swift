//
//  AppointmentVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire
import SwiftyJSON


class AppointmentVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet var calendarPopUp            : UIView!
    @IBOutlet weak var calendar            : FSCalendar!
    @IBOutlet weak var topSelectView       : UIView!
    @IBOutlet weak var topSelectLabel      : UILabel!
    @IBOutlet weak var topSelectText       : UITextField!
    @IBOutlet weak var appoinmentTableView : UITableView!
    @IBOutlet weak var changeDateBtn       : UIButton!
    @IBOutlet weak var noItemLabel         : UILabel!
 
    @IBOutlet weak var selectReservLab: UILabel!
    @IBOutlet weak var searchApptDate: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    
    var appoinmentPicker     = UIPickerView()
    var selectAppts          = [String]()
    var blackView            = UIView()
    var strDate              = String()
    var selectedDate         : String?
    
    var appoinmentList       = [allAppoinmentData]()
    var moreAppoinmentList   = [allAppoinmentData]()
    var currentDate          : String?
    var selectApptId         : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //"Today","Tomarrow","Select date"
        
        if resourceKey == "en" {
            selectAppts.append("Today")
            selectAppts.append("Tomarrow")
            selectAppts.append("Select date")
        }
        if resourceKey == "ar" {
            selectAppts.append("اليوم")
            selectAppts.append("غداً")
            selectAppts.append("اختيار التاريخ")
        }
        if resourceKey == "ckb" {
            selectAppts.append("رۆژ")
            selectAppts.append("كڕيار")
            selectAppts.append("دياريكردنى ڕێكەوت")
        }
        
        setLabelLanguageData(label: selectReservLab, key: "Select Reserve Time")
        setLabelLanguageData(label: searchApptDate, key: "Search Appoinments Date")
        setLabelLanguageData(label: noItemLabel, key: "No item")
        setLabelLanguageData(label: topSelectLabel, key: "Today")
        
        setButtonLanguageData(button: changeDateBtn, key: "date")
        setButtonLanguageData(button: doneBtn, key: "Done")
        
    
        getAllAppoinmet()
        navigationController?.navigationBar.tintColor = .black
        
        cornerButton(button: changeDateBtn, cornerValue: 6.0, maskToBounds: true)
        changeDateBtn.layer.borderColor = greenColor.cgColor
        changeDateBtn.layer.borderWidth = 0.6
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
//        self.navigationItem.rightBarButtonItem = logoImg
        
        appoinmentTableView.isHidden = true
        noItemLabel.isHidden = true
        changeDateBtn.isHidden = true
        creatAppoinmentPicker()
        
        setMessageLanguageData(&appointmentPageTitle, key: "Appointments")
        self.navigationItem.title = appointmentPageTitle
        
        navigationController?.navigationBar.tintColor = .black
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//            navigationItem.largeTitleDisplayMode = .always
//            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
//        } else {
//            // Fallback on earlier versions
//        }
        self.calendar.firstWeekday = 7
        
        topSelectText.tintColor = UIColor.clear
        topSelectText.text = ""
        calendar?.register(FSCalendarCell.self, forCellReuseIdentifier: "CalendarCell")
        cornerViews(view: calendarPopUp, cornerValue: 8.0, maskToBounds: true)
        cornerViews(view: topSelectView, cornerValue: 8.0, maskToBounds: true)
        cornerLabel(label: noItemLabel, cornerValue: 10.0, maskToBounds: true)
        FSCalendar.appearance().semanticContentAttribute = .forceLeftToRight
    }
    

    override func viewWillAppear(_ animated: Bool) {
        getAllAppoinmet()
        i = 2
    }
  
// *************************************** get all appoinments  ************************************************
    func getAllAppoinmet() {
        appoinmentList.removeAll()
        loading()
        // ------------------ current date ----------------
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_GB")
        currentDate = formatter.string(from: date)
        print(currentDate ?? "\(date)")

        let firstUrl = baseUrl + "appointments?start_date=" + (selectedDate ?? "\(currentDate!)")
        let secnUrl = "&end_date=" + (selectedDate ?? "\(currentDate!)")
        let appoinmentUrl = firstUrl + secnUrl
        print(appoinmentUrl)


        //        let requestApptparam: Parameters = [
        //            "status"            : "all",
        //            "user_id"           : "all",
        //            "start_date"        : selectedDate ?? "\(date)",
        //            "end_date"          : selectedDate ?? "\(date)"
        //        ]
        //        print(requestApptparam)

        ServiceAPI.shared.fetchGenericData(urlString: appoinmentUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: allAppoinmentModel?, error:Error?,status:Int?) in

            self.dismissLoding()
            if status == 200 {
                self.appoinmentList = model?.data ?? []
                print(self.appoinmentList)
                if self.appoinmentList.count > 0 {
                    self.appoinmentTableView.reloadData()
                    self.appoinmentTableView.isHidden = false
                    self.noItemLabel.isHidden = true
                }else{
                    self.appoinmentTableView.isHidden = true
                    self.noItemLabel.isHidden = false
                }
            }else if status == 401 || status == 404 {
                setMessageLanguageData(&unacouticated, key: "Unauthenticated! Please log out and login again")
                self.displayAlertMsg(userMsg: unacouticated)
                self.appoinmentTableView.isHidden = true
                self.noItemLabel.isHidden = false
            }
            else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }

        }
    }

    var i : Int = 2
    func loadMoreAppointment(){
        // ------------------ current date ----------------
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_GB")
        currentDate = formatter.string(from: date)
        print(currentDate ?? "\(date)")

        let firstUrl = baseUrl + "appointments?start_date=" + (selectedDate ?? "\(currentDate!)")
        let secnUrl = "&end_date=" + (selectedDate ?? "\(currentDate!)") + "&page=" + "\(i)"
        let appoinmentUrl = firstUrl + secnUrl
        print(appoinmentUrl)

        //        let requestApptparam: Parameters = [
        //            "status"            : "all",
        //            "start_date"        : selectedDate ?? "\(date)",
        //            "end_date"          : selectedDate ?? "\(date)"
        //        ]
        //
        //        print(requestApptparam)
        ServiceAPI.shared.fetchGenericData(urlString: appoinmentUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: allAppoinmentModel?, error:Error?,status:Int?) in

            self.dismissLoding()
            if status == 200 {
                self.moreAppoinmentList = model?.data ?? []
                if self.moreAppoinmentList.count > 0 {
                    for i in 0..<self.moreAppoinmentList.count {
                        self.appoinmentList.append(self.moreAppoinmentList[i])

                    }
                    self.i = self.i + 1
                    self.appoinmentTableView.reloadData()
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                let message = swiftyJsonVar["message"].string
                self.displayAlertMsg(userMsg: message ?? someThingWentWrong)
                self.appoinmentTableView.isHidden = true
                self.noItemLabel.isHidden = false
            }

        }
    }
    
    
//***************************** Request List ***********************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appoinmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reqCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableCell", for: indexPath) as! AppointmentTableViewCell
        
        reqCell.providerNameLabel.text = self.appoinmentList[indexPath.row].applicant?.name ?? "Provider name"
        reqCell.PatientLabel.text = self.appoinmentList[indexPath.row].client_name ?? "user name"
        reqCell.AppoinmentStatusLabel.text = self.appoinmentList[indexPath.row].status ?? "Confirm"
        let dateTime = self.appoinmentList[indexPath.row].start_time ?? ""
        let separate = dateTime.split(separator: " ")
        if separate.count > 0 {
            reqCell.timeLabel.text = "\(String(describing: separate[1]))"
            reqCell.dateLabel.text = "\(String(describing: separate[0]))"
        }
        reqCell.serviceNameLabel.text = self.appoinmentList[indexPath.row].service?.title ?? "servise"
        let status = self.appoinmentList[indexPath.row].status
        switch status {
        case "pending":
            reqCell.statusImage.image = pendingIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "pending")
        case "no-show":
            reqCell.statusImage.image = noShowIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "no show")
        case "confirmed":
            reqCell.statusImage.image = confirmIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "confirmed")
        case "done":
            reqCell.statusImage.image = doneIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "Done")
        default:
            print("ok")
        }

        if indexPath.row == self.appoinmentList.count - 1{
            self.loadMoreAppointment()
        }
        
        return reqCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectApptId = self.appoinmentList[indexPath.row].id ?? 1
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetails") as? AppointmentDetailsVC {
            vc.passedApptId = selectApptId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
// ********************************* Appoinment picker view *************************************
    func creatAppoinmentPicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        appoinmentPicker.delegate = self
        appoinmentPicker.dataSource = self
        topSelectText.inputAccessoryView = toolBar
        topSelectText.inputView = appoinmentPicker
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: false)
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectAppts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "row" //selectAppts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedItem = selectAppts[row]
        print(selectedItem)

        if resourceKey == "en" {
            if selectedItem == "Today" {
                selectedDate = currentDate
                topSelectLabel.text = selectedDate
                getAllAppoinmet()
            }
            
            if selectedItem == "Tomarrow" {
                selectedDate = "\(Date.tomorrow)"
                let separate = selectedDate?.split(separator: " ")
                if (separate?.count ?? 0) > 0 {
                    topSelectLabel.text = "\(separate![0])"
                    selectedDate = topSelectLabel.text
                    getAllAppoinmet()
                }
            }
            
            if selectedItem == "Select date" {
                self.view.endEditing(true)
                popAnimationIn(popView: calendarPopUp)
                changeDateBtn.isHidden = false
                topSelectLabel.text = "Select date"
            }else{
                changeDateBtn.isHidden = true
            }
        }
        if resourceKey == "ar" {
            if selectedItem == "اليوم" {
                selectedDate = currentDate
                topSelectLabel.text = selectedDate
                getAllAppoinmet()
            }
            
            if selectedItem == "Tomarrow" {
                selectedDate = "\(Date.tomorrow)"
                let separate = selectedDate?.split(separator: " ")
                if (separate?.count ?? 0) > 0 {
                    topSelectLabel.text = "\(separate![0])"
                    selectedDate = topSelectLabel.text
                    getAllAppoinmet()
                }
            }
            
            if selectedItem == "اختيار التاريخ" {
                self.view.endEditing(true)
                popAnimationIn(popView: calendarPopUp)
                changeDateBtn.isHidden = false
                topSelectLabel.text = "اختيار التاريخ"
            }else{
                changeDateBtn.isHidden = true
            }
        }
        if resourceKey == "ckb" {
            if selectedItem == "رۆژ" {
                selectedDate = currentDate
                topSelectLabel.text = selectedDate
                getAllAppoinmet()
            }
            
            if selectedItem == "كڕيار" {
                selectedDate = "\(Date.tomorrow)"
                let separate = selectedDate?.split(separator: " ")
                if (separate?.count ?? 0) > 0 {
                    topSelectLabel.text = "\(separate![0])"
                    selectedDate = topSelectLabel.text
                    getAllAppoinmet()
                }
            }
            
            if selectedItem == "دياريكردنى ڕێكەوت" {
                self.view.endEditing(true)
                popAnimationIn(popView: calendarPopUp)
                changeDateBtn.isHidden = false
                topSelectLabel.text = "دياريكردنى ڕێكەوت"
            }else{
                changeDateBtn.isHidden = true
            }
        }
    }
    
    @IBAction func changeDateTapped(_ sender: Any) {
        popAnimationIn(popView: calendarPopUp)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var lable: UILabel
        if let view = view as? UILabel{
            lable = view
        }else {
            lable = UILabel()
        }
        lable.textColor     = .black
        lable.textAlignment = .center
        lable.font = UIFont.boldSystemFont(ofSize: 14.0)
        if pickerView == appoinmentPicker{
            lable.text = selectAppts[row]
        }
        return lable
    }
    
    
    @IBAction func calendarDismiss(_ sender: Any) {
        popAnimateOut(popView: calendarPopUp)
    }
    
    @IBAction func getCalendarDateTapped(_ sender: Any) {
        popAnimateOut(popView: calendarPopUp)
        getAllAppoinmet()
    }
    
// ********************************* Calendar *************************************
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CalendarCell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY/MM/dd"
        dateFormater.locale = Locale(identifier: "en_GB")
        selectedDate = dateFormater.string(from: date)
        topSelectLabel.text = selectedDate
    }
    
// -------------------------------- Animation -------------------------------
    func popAnimationIn(popView: UIView){
        if let window = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            blackView.frame = window.frame
            window.addSubview(blackView)
            popView.center = self.view.center
            popView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            popView.alpha = 0
            UIApplication.shared.keyWindow?.addSubview(popView)
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                popView.alpha = 1
                popView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    func popAnimateOut(popView: UIView){
        UIView.animate(withDuration: 0.5, animations: {
            popView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            popView.alpha = 0
            self.blackView.alpha = 0
        }) { (success:Bool) in
            popView.removeFromSuperview()
        }
    }
    
    
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
}



extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
