//
//  IndustryWorkingHoursVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON


class IndustryWorkingHoursVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var setHoursLab: UILabel!
    @IBOutlet weak var hoursMessageLab: UILabel!
    
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var oneLable: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    
    
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
    
    @IBOutlet weak var nextBtnOutlet: UIButton!
    
    
    var createIndustryList   = [String : AnyObject]()
    var timePicker           = UIDatePicker()
    var phoneNumber           : String?
    var alertcontroller        : UIAlertController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: setHoursLab, key: "set your business hours")
        setLabelLanguageData(label: hoursMessageLab, key: "Let your customers know when you're open")
        setButtonLanguageData(button: nextBtnOutlet, key: "Next")
        
        setLabelLanguageData(label: satLabel, key: "Saturday")
        setLabelLanguageData(label: sunLabel, key: "Sunday")
        setLabelLanguageData(label: monLabel, key: "Monday")
        setLabelLanguageData(label: tueLabel, key: "Tuesday")
        setLabelLanguageData(label: wedLabel, key: "Wednesday")
        setLabelLanguageData(label: thuLabel, key: "Thursday")
        setLabelLanguageData(label: friLabel, key: "Friday")
        
        setLabelLanguageData(label: welcomeLabel, key: "Welcome")
        setLabelLanguageData(label: mapLabel, key: "location")
        setLabelLanguageData(label: hoursLabel, key: "hours")
        setLabelLanguageData(label: staffLabel, key: "staff")
        setLabelLanguageData(label: serviceLabel, key: "Service")
        
        satSwicher.semanticContentAttribute = .forceLeftToRight
        sunSwitcher.semanticContentAttribute = .forceLeftToRight
        monSwitcher.semanticContentAttribute = .forceLeftToRight
        tueSwitcher.semanticContentAttribute = .forceLeftToRight
        wedSwitcher.semanticContentAttribute = .forceLeftToRight
        thuSwitcher.semanticContentAttribute = .forceLeftToRight
        friSwitcher.semanticContentAttribute = .forceLeftToRight
        
        
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
        
        setMessageLanguageData(&workingHoursPageTitle, key: "Working Hours")
        self.navigationItem.title = workingHoursPageTitle
        
        cornerViews(view: hoursView, cornerValue: 6.0, maskToBounds: true)
        cornerButton(button: nextBtnOutlet, cornerValue: 6.0, maskToBounds: true)
        createTimePicker()
        
        oneLable.backgroundColor = stepOnLabelColor
        twoLabel.backgroundColor = stepOnLabelColor
        threeLabel.backgroundColor = stepOnLabelColor
        fourLabel.backgroundColor = stepOffLabelColor
        fiveLabel.backgroundColor = stepOffLabelColor
        
        cornerLabel(label: oneLable, cornerValue: Float(oneLable.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: twoLabel, cornerValue: Float(twoLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: threeLabel, cornerValue: Float(threeLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fourLabel, cornerValue: Float(fourLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fiveLabel, cornerValue: Float(fiveLabel.frame.height / 2) , maskToBounds: true)
        
        
        // ------------ default -------------------------
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
    
    
    
    // ******************************** time picker **********************************
    
    func createTimePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 30
        timePicker.locale = Locale(identifier: "en_GB")
        //        timePicker.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.persian)! as Calendar
        //        timePicker.locale = NSLocale(localeIdentifier: "fa_IR") as Locale
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
    
    // ********************************** set text ****************************************
    func textFieldDidEndEditing(_ textField: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_GB")
        if textField.tag == 0 {
            print(dateFormatter.string(from: timePicker.date))
            satFromText.text = dateFormatter.string(from: timePicker.date)
        }
        if textField.tag == 1 {
            print(dateFormatter.string(from: timePicker.date))
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
    
    
    @IBAction func nextTapped(_ sender: Any) {
       
        setMessageLanguageData(&startIsEmpty, key: "start time is empty")
        setMessageLanguageData(&endIsEmpty, key: "end time is empty")
        
        loading()
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
                //                WorkingHoursss(day: "1", time: ["8:00" , "16:00"])
                //                timeArr.append(satFromText.text ?? "")
                //                timeArr.append(satToText.text ?? "")
                //                workingHours.append(hoursModel(day: 1, time: timeArr))
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
        if workingHours.count == 0 {
            self.dismissLoding()
            
            setMessageLanguageData(&setYourHors, key: "please set your working hours")
            self.displayAlertMsg(userMsg: setYourHors)
        }else{
            createIndustry()
        }
    }
    
    // ************************************ Create An Industry *************************************
    func createIndustry(){
        loading()
        print(workingHours)
        let createIndustryUrl = baseUrl + "industries"
        print(createIndustryUrl)

        let model = createIndustryyy(working_hours: workingHours, address: bussinesAddress, description: adminDesc, title: bussinesTitle, category_id: selectedCategoryId, city_id: selectedCityId, phone: bussinessPhone, lat: businessLat, lng: businessLng)
        print(model)

        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(model)
            jsonEncoder.outputFormatting = .prettyPrinted

            let url = URL(string: createIndustryUrl)
            var request = URLRequest(url: url!)
            request.httpMethod = HTTPMethod.post.rawValue
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
                //                stopActivity(view: self.view)
                //                print(response)
                //                print(response.response?.statusCode)
                let status = response.response?.statusCode
//                print(status)

                if status == 200 || status == 201 {
                    if (response.result.value) != nil {
                        let swiftyJsonVar = JSON(response.result.value)
                        print("swiftyJsonVar ---------- ",swiftyJsonVar)

                        if let resData = swiftyJsonVar["data"].dictionaryObject {
                            self.createIndustryList = resData as? [String:AnyObject] ?? [:]
                            print(self.createIndustryList)

                            industryID = self.createIndustryList["id"] as! Int?
                            //                        print(industryID)

                            setMessageLanguageData(&industrySave, key: "your industry Successfully Save! and Now you can define Your Services and your staff")
                            self.displaySuccessMsg(userMsg: industrySave)
                        }else{
                            setMessageLanguageData(&someThingWentWrong, key: "somthing went wrong")
                            self.displayAlertMsg(userMsg: someThingWentWrong)
                        }
                    }
                }else{
                    if (response.result.value) != nil {
                        let swiftyJsonVar = JSON(response.result.value)
                        print("swiftyJsonVar ---------- ",swiftyJsonVar)
                        if let errors = swiftyJsonVar["errors"].dictionaryObject {
                            if let phone = errors["phone"] {
                                print(phone)
                                self.correctTitle = "phone number"
                                setMessageLanguageData(&youPhoneIncorect, key: "Your phone is incorrect")
                                self.displayPhoneAlertMsg(userMsg: youPhoneIncorect)
                            }
                            if let address = errors["address"] {
                                print(address)
                                setMessageLanguageData(&youAddressIncorect, key: "Your address is incorrect")
                                self.displayErrorAlertMsg(userMsg: youAddressIncorect)
                            }
                            if let horse = errors["working_hours"] {
                                print(horse)
                                setMessageLanguageData(&youWorkingHoursIncorect, key: "Your working hours is incorrect")
                                self.displayAlertMsg(userMsg: youWorkingHoursIncorect)
                            }
                            if let title = errors["title"] {
                                print(title)
                                self.correctTitle = "title"
                                setMessageLanguageData(&youTitleIncorect, key: "Your title is incorrect")
                                self.displayPhoneAlertMsg(userMsg: youTitleIncorect)
                            }
                            if let city = errors["city_id"] {
                                print(city)
                                setMessageLanguageData(&youCityIncorect, key: "Your city is incorrect")
                                self.displayErrorAlertMsg(userMsg: youCityIncorect)
                            }
                        }
                    }
                }
            }

        }catch {

        }
    }
    
    var correctTitle = String()
    func getPhonNumber(){
        alertcontroller = UIAlertController(title: ("Correct " + correctTitle), message: "enter correct " + correctTitle +  " and then Next", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
        }
        alertcontroller?.addAction(alertAction)
        alertcontroller?.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "enter your correct " + self.correctTitle
            textField.textAlignment = .center
            let alertActionForTextField = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                if let textField = self.alertcontroller?.textFields{
                    let theTextField = textField
                    if self.correctTitle == "title" {
                        bussinesTitle = theTextField[0].text!
                    }
                    if self.correctTitle == "phone number" {
                        bussinessPhone = theTextField[0].text!
                    }
                    workingHours.removeAll()
                }
            })
            self.alertcontroller?.addAction(alertActionForTextField)
        })
        present(alertcontroller!, animated: true, completion: nil)
    }
    
    
    func displaySuccessMsg(userMsg: String){
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            saveToken(token: accesssToken)
            self.saveIndustryId(id: industryID ?? 1)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displayPhoneAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.getPhonNumber()
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displayErrorAlertMsg(userMsg: String){
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: "Ok", style: .default, handler: { action in
            let destVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "industryPage") as! IndustryVC
            self.present(destVC, animated: false, completion: nil)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    func saveIndustryId(id: Int) {
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Industry", into: context)
        newUser.setValue(id, forKey: "industryId")
        newUser.setValue(bussinesAddress, forKey: "businessAddress")
        newUser.setValue(bussinessPhone, forKey: "businessPhone")
        newUser.setValue(bussinesTitle, forKey: "businessTitle")
        newUser.setValue(selectedCategoryId, forKey: "categoryId")
        do{
            try context.save()
            print("saved industryId: \(String(describing: industryID))")
            performSegue(withIdentifier: "toService", sender: self)
        }catch{
            //
        }
    }
}


var workingHours   : [WorkingHoursss] = []

var startIsEmpty = String()
var endIsEmpty = String()

var setYourHors = String()
var industrySave = String()

var youPhoneIncorect = String()
var youAddressIncorect = String()
var youWorkingHoursIncorect = String()
var youCityIncorect = String()
var youTitleIncorect = String()
