//
//  WorkingHoursVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WorkingHoursVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var setHoursLab: UILabel!
    @IBOutlet weak var hoursMessageLab: UILabel!
    
    
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var satFromText: UITextField!
    @IBOutlet weak var satToText: UITextField!
    @IBOutlet weak var satSwicher: UISwitch!
    @IBOutlet weak var satLabel: UILabel!
    
    @IBOutlet weak var sunFromText: UITextField!
    @IBOutlet weak var sunToText: UITextField!
    @IBOutlet weak var sunSwitcher: UISwitch!
    @IBOutlet weak var sunLabel: UILabel!
    
    @IBOutlet weak var monFRomText: UITextField!
    @IBOutlet weak var monToText: UITextField!
    @IBOutlet weak var monSwitcher: UISwitch!
    @IBOutlet weak var monLabel: UILabel!
    
    @IBOutlet weak var tueFromText: UITextField!
    @IBOutlet weak var tueToText: UITextField!
    @IBOutlet weak var tueSwitcher: UISwitch!
    @IBOutlet weak var tueLabel: UILabel!
    
    @IBOutlet weak var wedFromText: UITextField!
    @IBOutlet weak var wedToText: UITextField!
    @IBOutlet weak var wedSwitcher: UISwitch!
    @IBOutlet weak var wedLabel: UILabel!
    
    @IBOutlet weak var thuFromText: UITextField!
    @IBOutlet weak var thuToText: UITextField!
    @IBOutlet weak var thuSwitcher: UISwitch!
    @IBOutlet weak var thuLabel: UILabel!
    
    @IBOutlet weak var friFtomText: UITextField!
    @IBOutlet weak var friToText: UITextField!
    @IBOutlet weak var friSwitcher: UISwitch!
    @IBOutlet weak var friLabel: UILabel!
    
    @IBOutlet weak var saveBtnOutlet: UIButton!
    
    
    var timePicker     = UIDatePicker()
    
    var days = [Int]()
    var starts = [String]()
    var ends = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: setHoursLab, key: "set your business hours")
        setLabelLanguageData(label: hoursMessageLab, key: "Let your customers know when you're open")
        setButtonLanguageData(button: saveBtnOutlet, key: "save")
        
        setLabelLanguageData(label: satLabel, key: "Saturday")
        setLabelLanguageData(label: sunLabel, key: "Sunday")
        setLabelLanguageData(label: monLabel, key: "Monday")
        setLabelLanguageData(label: tueLabel, key: "Tuesday")
        setLabelLanguageData(label: wedLabel, key: "Wednesday")
        setLabelLanguageData(label: thuLabel, key: "Thursday")
        setLabelLanguageData(label: friLabel, key: "Friday")
        
        satSwicher.semanticContentAttribute = .forceLeftToRight
        sunSwitcher.semanticContentAttribute = .forceLeftToRight
        monSwitcher.semanticContentAttribute = .forceLeftToRight
        tueSwitcher.semanticContentAttribute = .forceLeftToRight
        wedSwitcher.semanticContentAttribute = .forceLeftToRight
        thuSwitcher.semanticContentAttribute = .forceLeftToRight
        friSwitcher.semanticContentAttribute = .forceLeftToRight
        
        for i in 0..<settingWorkHours.count  {
            let day = settingWorkHours[i].day ?? 1
            let start = settingWorkHours[i].start ?? ""
            let end = settingWorkHours[i].end ?? ""
            days.append(day)
            starts.append(start)
            ends.append(end)
        }
        print(days)
        print(starts)
        print(ends)
        
        setMessageLanguageData(&workingHoursPageTitle, key: "working hours")
        self.navigationItem.title = workingHoursPageTitle
        
        cornerViews(view: hoursView, cornerValue: 6.0, maskToBounds: true)
        cornerButton(button: saveBtnOutlet, cornerValue: 6.0, maskToBounds: true)
        createTimePicker()
        
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
        
        // --------------------- default -------------------------
        
        if days.count > 0 {
            for j in 0..<days.count {
                print(days[j])
                
                if days.contains(0) {
                    if days[j] == 0 {
                        satSwicher.isOn = true
                        satFromText.isEnabled = true
                        satFromText.backgroundColor = .white
                        satFromText.text = starts[j]
                        satToText.isEnabled = true
                        satToText.backgroundColor = .white
                        satToText.text = ends[j]
                        satLabel.textColor = .black
                    }
                }else{
                    satSwicher.isOn = false
                    satFromText.isEnabled = false
                    satFromText.backgroundColor = .lightGray
                    satFromText.text = ""
                    satToText.isEnabled = false
                    satToText.backgroundColor = .lightGray
                    satToText.text = ""
                    satLabel.textColor = .lightGray
                }
                
                if days.contains(1){
                    if days[j] == 1 {
                        sunSwitcher.isOn = true
                        sunFromText.isEnabled = true
                        sunFromText.backgroundColor = .white
                        sunFromText.text = starts[j]
                        sunToText.isEnabled = true
                        sunToText.backgroundColor = .white
                        sunToText.text = ends[j]
                        sunLabel.textColor = .black
                    }
                }else{
                    sunSwitcher.isOn = false
                    sunFromText.isEnabled = false
                    sunFromText.backgroundColor = .lightGray
                    sunFromText.text = ""
                    sunToText.isEnabled = false
                    sunToText.backgroundColor = .lightGray
                    sunToText.text = ""
                    sunLabel.textColor = .lightGray
                }
                
                if days.contains(2){
                    if days[j] == 2 {
                        monSwitcher.isOn = true
                        monFRomText.isEnabled = true
                        monFRomText.backgroundColor = .white
                        monFRomText.text = starts[j]
                        monToText.isEnabled = true
                        monToText.backgroundColor = .white
                        monToText.text = ends[j]
                        monLabel.textColor = .black
                    }
                }else{
                    monSwitcher.isOn = false
                    monFRomText.isEnabled = false
                    monFRomText.backgroundColor = .lightGray
                    monFRomText.text = ""
                    monToText.isEnabled = false
                    monToText.backgroundColor = .lightGray
                    monToText.text = ""
                    monLabel.textColor = .lightGray
                }
                
                if days.contains(3) {
                    if days[j] == 3 {
                        tueSwitcher.isOn = true
                        tueFromText.isEnabled = true
                        tueFromText.backgroundColor = .white
                        tueFromText.text = starts[j]
                        tueToText.isEnabled = true
                        tueToText.backgroundColor = .white
                        tueToText.text = ends[j]
                        tueLabel.textColor = .black
                    }
                }else{
                    tueSwitcher.isOn = false
                    tueFromText.isEnabled = false
                    tueFromText.backgroundColor = .lightGray
                    tueFromText.text = ""
                    tueToText.isEnabled = false
                    tueToText.backgroundColor = .lightGray
                    tueToText.text = ""
                    tueLabel.textColor = .lightGray
                }
                
                if days.contains(4) {
                    if days[j] == 4 {
                        wedSwitcher.isOn = true
                        wedFromText.isEnabled = true
                        wedFromText.backgroundColor = .white
                        wedFromText.text = starts[j]
                        wedToText.isEnabled = true
                        wedToText.backgroundColor = .white
                        wedToText.text = ends[j]
                        wedLabel.textColor = .black
                    }
                }else{
                    wedSwitcher.isOn = false
                    wedFromText.isEnabled = false
                    wedFromText.backgroundColor = .lightGray
                    wedFromText.text = ""
                    wedToText.isEnabled = false
                    wedToText.backgroundColor = .lightGray
                    wedToText.text = ""
                    wedLabel.textColor = .lightGray
                }
                
                if days.contains(5){
                    if days[j] == 5 {
                        thuSwitcher.isOn = true
                        thuFromText.isEnabled = true
                        thuFromText.backgroundColor = .white
                        thuFromText.text = starts[j]
                        thuToText.isEnabled = true
                        thuToText.backgroundColor = .white
                        thuToText.text = ends[j]
                        thuLabel.textColor = .black
                    }
                }else{
                    thuSwitcher.isOn = false
                    thuFromText.isEnabled = false
                    thuFromText.backgroundColor = .lightGray
                    thuFromText.text = ""
                    thuToText.isEnabled = false
                    thuToText.backgroundColor = .lightGray
                    thuToText.text = ""
                    thuLabel.textColor = .lightGray
                }
                
                if days.contains(6) {
                    if days[j] == 6 {
                        friSwitcher.isOn = true
                        friFtomText.isEnabled = true
                        friFtomText.backgroundColor = .white
                        friFtomText.text = starts[j]
                        friToText.isEnabled = true
                        friToText.backgroundColor = .white
                        friToText.text = ends[j]
                        friLabel.textColor = .black
                    }
                }else{
                    friSwitcher.isOn = false
                    friFtomText.isEnabled = false
                    friFtomText.backgroundColor = .lightGray
                    friFtomText.text = ""
                    friToText.isEnabled = false
                    friToText.backgroundColor = .lightGray
                    friToText.text = ""
                    friLabel.textColor = .lightGray
                }
            }
        }else{
            satSwicher.isOn = false
            satFromText.isEnabled = false
            satFromText.backgroundColor = .lightGray
            satToText.isEnabled = false
            satToText.backgroundColor = .lightGray
            satLabel.textColor = .lightGray
            
            sunSwitcher.isOn = false
            sunFromText.isEnabled = false
            sunFromText.backgroundColor = .lightGray
            sunToText.isEnabled = false
            sunToText.backgroundColor = .lightGray
            sunLabel.textColor = .lightGray
            
            monSwitcher.isOn = false
            monFRomText.isEnabled = false
            monFRomText.backgroundColor = .lightGray
            monToText.isEnabled = false
            monToText.backgroundColor = .lightGray
            monLabel.textColor = .lightGray
            
            tueSwitcher.isOn = false
            tueFromText.isEnabled = false
            tueFromText.backgroundColor = .lightGray
            tueToText.isEnabled = false
            tueToText.backgroundColor = .lightGray
            tueLabel.textColor = .lightGray
            
            wedSwitcher.isOn = false
            wedFromText.isEnabled = false
            wedFromText.backgroundColor = .lightGray
            wedToText.isEnabled = false
            wedToText.backgroundColor = .lightGray
            wedLabel.textColor = .lightGray
            
            thuSwitcher.isOn = false
            thuFromText.isEnabled = false
            thuFromText.backgroundColor = .lightGray
            thuToText.isEnabled = false
            thuToText.backgroundColor = .lightGray
            thuLabel.textColor = .lightGray
            
            friSwitcher.isOn = false
            friFtomText.isEnabled = false
            friFtomText.backgroundColor = .lightGray
            friToText.isEnabled = false
            friToText.backgroundColor = .lightGray
            friLabel.textColor = .lightGray
        }
    }
    
    // ******************************** switcher *********************************
    @IBAction func satSwitch(_ sender: UISwitch) {
        if satSwicher.isOn {
            satFromText.isEnabled = true
            satFromText.backgroundColor = .white
            satToText.isEnabled = true
            satToText.backgroundColor = .white
            satLabel.textColor = .black
        }else{
            satFromText.isEnabled = false
            satFromText.backgroundColor = .lightGray
            satToText.isEnabled = false
            satToText.backgroundColor = .lightGray
            satLabel.textColor = .lightGray
        }
    }
    
    @IBAction func sanSwitch(_ sender: UISwitch) {
        if sunSwitcher.isOn {
            sunFromText.isEnabled = true
            sunFromText.backgroundColor = .white
            sunToText.isEnabled = true
            sunToText.backgroundColor = .white
            sunLabel.textColor = .black
        }else{
            sunFromText.isEnabled = false
            sunFromText.backgroundColor = .lightGray
            sunToText.isEnabled = false
            sunToText.backgroundColor = .lightGray
            sunLabel.textColor = .lightGray
        }
    }
    
    @IBAction func monSwitch(_ sender: UISwitch) {
        if monSwitcher.isOn {
            monFRomText.isEnabled = true
            monFRomText.backgroundColor = .white
            monToText.isEnabled = true
            monToText.backgroundColor = .white
            monLabel.textColor = .black
        }else{
            monFRomText.isEnabled = false
            monFRomText.backgroundColor = .lightGray
            monToText.isEnabled = false
            monToText.backgroundColor = .lightGray
            monLabel.textColor = .lightGray
        }
    }
    
    @IBAction func tueSwitch(_ sender: UISwitch) {
        if tueSwitcher.isOn {
            tueFromText.isEnabled = true
            tueFromText.backgroundColor = .white
            tueToText.isEnabled = true
            tueToText.backgroundColor = .white
            tueLabel.textColor = .black
        }else{
            tueFromText.isEnabled = false
            tueFromText.backgroundColor = .lightGray
            tueToText.isEnabled = false
            tueToText.backgroundColor = .lightGray
            tueLabel.textColor = .lightGray
        }
    }
    
    @IBAction func wedSwitch(_ sender: UISwitch) {
        if wedSwitcher.isOn {
            wedFromText.isEnabled = true
            wedFromText.backgroundColor = .white
            wedToText.isEnabled = true
            wedToText.backgroundColor = .white
            wedLabel.textColor = .black
        }else{
            wedFromText.isEnabled = false
            wedFromText.backgroundColor = .lightGray
            wedToText.isEnabled = false
            wedToText.backgroundColor = .lightGray
            wedLabel.textColor = .lightGray
        }
    }
    
    @IBAction func thuSwitch(_ sender: UISwitch) {
        if thuSwitcher.isOn {
            thuFromText.isEnabled = true
            thuFromText.backgroundColor = .white
            thuToText.isEnabled = true
            thuToText.backgroundColor = .white
            thuLabel.textColor = .black
        }else{
            thuFromText.isEnabled = false
            thuFromText.backgroundColor = .lightGray
            thuToText.isEnabled = false
            thuToText.backgroundColor = .lightGray
            thuLabel.textColor = .lightGray
        }
    }
    
    @IBAction func friSwitch(_ sender: UISwitch) {
        if friSwitcher.isOn {
            friFtomText.isEnabled = true
            friFtomText.backgroundColor = .white
            friToText.isEnabled = true
            friToText.backgroundColor = .white
            friLabel.textColor = .black
        }else{
            friFtomText.isEnabled = false
            friFtomText.backgroundColor = .lightGray
            friToText.isEnabled = false
            friToText.backgroundColor = .lightGray
            friLabel.textColor = .lightGray
        }
    }
    
    
    func createTimePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 30
        timePicker.locale = Locale(identifier: "en_GB")
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(DonePressed))
        toolBar.setItems([doneButton], animated: false)
        
        satFromText.inputAccessoryView = toolBar
        satFromText.inputView = timePicker
        satToText.inputAccessoryView = toolBar
        satToText.inputView = timePicker
        
        sunFromText.inputAccessoryView = toolBar
        sunFromText.inputView = timePicker
        sunToText.inputAccessoryView = toolBar
        sunToText.inputView = timePicker
        
        monFRomText.inputAccessoryView = toolBar
        monFRomText.inputView = timePicker
        monToText.inputAccessoryView = toolBar
        monToText.inputView = timePicker
        
        tueFromText.inputAccessoryView = toolBar
        tueFromText.inputView = timePicker
        tueToText.inputAccessoryView = toolBar
        tueToText.inputView = timePicker
        
        wedFromText.inputAccessoryView = toolBar
        wedFromText.inputView = timePicker
        wedToText.inputAccessoryView = toolBar
        wedToText.inputView = timePicker
        
        thuFromText.inputAccessoryView = toolBar
        thuFromText.inputView = timePicker
        thuToText.inputAccessoryView = toolBar
        thuToText.inputView = timePicker
        
        friFtomText.inputAccessoryView = toolBar
        friFtomText.inputView = timePicker
        friToText.inputAccessoryView = toolBar
        friToText.inputView = timePicker
        
    }
    
    @objc func DonePressed(){
        self.view.endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_GB")
        if textField.tag == 0 {
            satFromText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 1 {
            satToText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 2 {
            sunFromText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 3 {
            sunToText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 4 {
            monFRomText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 5 {
            monToText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 6 {
            tueFromText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 7 {
            tueToText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 8 {
            wedFromText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 9 {
            wedToText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 10 {
            thuFromText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 11 {
            thuToText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 12 {
            friFtomText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 13 {
            friToText.text = dateFormatter.string(from: timePicker.date)
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        setMessageLanguageData(&startIsEmpty, key: "start time is empty")
        setMessageLanguageData(&endIsEmpty, key: "end time is empty")
        
        
        loading()
        workingHours.removeAll()
        // ----------------------- saturday ----------------------------------
        if satSwicher.isOn {
            if (satFromText.text == "" || (satFromText.text?.isEmpty)!) || (satToText.text == "" || (satToText.text?.isEmpty)!){
                if (satFromText.text == "" || (satFromText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (satToText.text == "" || (satToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 0, time: [satFromText.text ?? "" , satToText.text ?? ""]))
            }
        }

        // ----------------------- sunday ----------------------------------
        if sunSwitcher.isOn {
            if (sunFromText.text == "" || (sunFromText.text?.isEmpty)!) || (sunToText.text == "" || (sunToText.text?.isEmpty)!){
                if (sunFromText.text == "" || (sunFromText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (sunToText.text == "" || (sunToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 1, time: [sunFromText.text ?? "" , sunToText.text ?? ""]))
            }
        }

        // ----------------------- monday ----------------------------------
        if monSwitcher.isOn {
            if (monFRomText.text == "" || (monFRomText.text?.isEmpty)!) || (monToText.text == "" || (monToText.text?.isEmpty)!){
                if (monFRomText.text == "" || (monFRomText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (monToText.text == "" || (monToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 2, time: [monFRomText.text ?? "" , monToText.text ?? ""]))
                print(workingHours)
            }
        }

        // ----------------------- tuesday ----------------------------------
        if tueSwitcher.isOn {
            if (tueFromText.text == "" || (tueFromText.text?.isEmpty)!) || (tueToText.text == "" || (tueToText.text?.isEmpty)!){
                if (tueFromText.text == "" || (tueFromText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (tueToText.text == "" || (tueToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 3, time: [tueFromText.text ?? "" , tueToText.text ?? ""]))
            }
        }

        // ----------------------- wednesday ----------------------------------
        if wedSwitcher.isOn {
            if (wedFromText.text == "" || (wedFromText.text?.isEmpty)!) || (wedToText.text == "" || (wedToText.text?.isEmpty)!){
                if (wedFromText.text == "" || (wedFromText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (wedToText.text == "" || (wedToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 4, time: [wedFromText.text ?? "" , wedToText.text ?? ""]))
            }
        }

        // ----------------------- thurday ----------------------------------
        if thuSwitcher.isOn {
            if (thuFromText.text == "" || (thuFromText.text?.isEmpty)!) || (thuToText.text == "" || (thuToText.text?.isEmpty)!){
                if (thuFromText.text == "" || (thuFromText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (thuToText.text == "" || (thuToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 5, time: [thuFromText.text ?? "" , thuToText.text ?? ""]))
            }
        }

        // ----------------------- thurday ----------------------------------
        if friSwitcher.isOn {
            if (friFtomText.text == "" || (friFtomText.text?.isEmpty)!) || (friToText.text == "" || (friToText.text?.isEmpty)!){
                if (friFtomText.text == "" || (friFtomText.text?.isEmpty)!) {
                    displayAlertMsg(userMsg: startIsEmpty)
                }
                if (friToText.text == "" || (friToText.text?.isEmpty)!){
                    displayAlertMsg(userMsg: endIsEmpty)
                }
            }else{
                workingHours.append(WorkingHoursss(day: 6, time: [friFtomText.text ?? "" , friToText.text ?? ""]))
            }
        }


        print(workingHours)
        let updateWorkingHoursUrl = baseUrl + "industries/" + "\(industryID ?? 1)" + "/workingHours"
        print(updateWorkingHoursUrl)

        let model = [ "working_hours": workingHours ]
        print(model)
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(model)
            jsonEncoder.outputFormatting = .prettyPrinted

            let url = URL(string: updateWorkingHoursUrl)
            var request = URLRequest(url: url!)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(accesssToken)",
                "X-Requested-With": "application/json",
                "Content-type" : "application/json",
                "Accept" : "application/json"
            ]
            print(jsonData)
            Alamofire.request(request).responseJSON {
                (response) in
                self.dismissLoding()
                print(response)
//                print(response.response?.statusCode)
                if (response.result.value) != nil {
                    let swiftyJsonVar = JSON(response.result.value)
                    print("swiftyJsonVar ---------- ",swiftyJsonVar)

                    if let resData = swiftyJsonVar["data"].dictionaryObject {
                        print(resData)
                        setMessageLanguageData(&updateWorkingHours, key: "your industry working hours Successfuly Updated")
                        self.displaySuccessMsg(userMsg: updateWorkingHours)
                    }else{
                        setMessageLanguageData(&someThingWentWrong, key: "somthing went wrong")
                        self.displayAlertMsg(userMsg: someThingWentWrong)
                    }
                }
            }

        }catch {

        }
    }
    
    // ********************************** show an industry **********************************
    
    func getIndustryData(){
        let industryUrl = baseUrl + "industries/" + "\(industryID ?? 0)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: showIndustryModel?, error:Error?,status:Int?) in
//            print(status)
            if status == 200 {
                let showIndustryDetails = model?.data
//                print(showIndustryDetails)
            }
        }
    }
    
    func displaySuccessMsg(userMsg: String){
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    func displayAlertMsg(userMsg: String){func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
        }
    }
}

var updateWorkingHours = String()
