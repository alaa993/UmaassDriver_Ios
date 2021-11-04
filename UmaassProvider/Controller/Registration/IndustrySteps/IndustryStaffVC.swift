//
//  IndustryStaffVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class IndustryStaffVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, manageStaffDelegate {
    
    
    
    @IBOutlet weak var oneLable         : UILabel!
    @IBOutlet weak var welcomeLabel     : UILabel!
    @IBOutlet weak var twoLabel         : UILabel!
    @IBOutlet weak var mapLabel         : UILabel!
    @IBOutlet weak var threeLabel       : UILabel!
    @IBOutlet weak var staffLabel       : UILabel!
    @IBOutlet weak var fourLabel        : UILabel!
    @IBOutlet weak var hoursLabel    : UILabel!
    @IBOutlet weak var fiveLabel        : UILabel!
    @IBOutlet weak var serviceLabel     : UILabel!
    
    @IBOutlet weak var addStaffTableView: UITableView!
    @IBOutlet var addStaffPopView       : UIView!
    
    @IBOutlet weak var staffListView    : UIView!
    @IBOutlet weak var nameText         : UITextField!
    @IBOutlet weak var rollText         : UITextField!
    @IBOutlet weak var permissinsText   : UITextField!
    @IBOutlet weak var phoneText        : UITextField!
    @IBOutlet weak var saveBtnOutlet    : UIButton!
    @IBOutlet weak var addMember: UILabel!
    
    @IBOutlet weak var setStaffLab: UILabel!
    @IBOutlet weak var staffMessageLab: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    
    var blackView             = UIView()
    
    var rolePicker            = UIPickerView()
    var roleToolBar           = UIToolbar()
    
    var permissionsPicker         = UIPickerView()
    var permissionsToolBar        = UIToolbar()
    
    
    //    var showIndustryDetails   = ShowIndustryData()
    var showServicesList              = [ShowIndustryServices]()
    var showStaffList                 = [ShowIndustryStaff]()
    var selectedPermissionId          = Int()
    var selectedPermissionIdArr       = [Int]()
    
    var selectedPermissionTitle       = String()
    var selectedPermissionsTitleArr   = [String]()
    
    var indexDelete           = Int()
    var editIndex             = Int()
    var isEdited              : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: setStaffLab, key: "Add your staff")
        setLabelLanguageData(label: staffMessageLab, key: "you can always edit these")
        setButtonLanguageData(button: saveBtnOutlet, key: "Next")
        
        setLabelLanguageData(label: addMember, key: "Add your staff")
        setButtonLanguageData(button: addBtn, key: "add")
        
        setLabelLanguageData(label: welcomeLabel, key: "Welcome")
        setLabelLanguageData(label: mapLabel, key: "location")
        setLabelLanguageData(label: hoursLabel, key: "hours")
        setLabelLanguageData(label: staffLabel, key: "staff")
        setLabelLanguageData(label: serviceLabel, key: "Service")
        
        print(showStaffList)
        //        InitializerSpinner(view: self.view)
        getServicesandStaff()
        
        createRolePicker()
        createRoleToolBar()
        createPermissionsPicker()
        createpermissionsToolBar()
        
        setMessageLanguageData(&setStaffPageTitle, key: "Staff")
        self.navigationItem.title = setStaffPageTitle
        
        
        cornerViews(view: addStaffPopView, cornerValue: 8.0, maskToBounds: true)
        cornerViews(view: staffListView, cornerValue: 6.0, maskToBounds: true)
        cornerButton(button: saveBtnOutlet, cornerValue: 6.0, maskToBounds: true)
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: view.frame.width / 2, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
        
        let addStaffBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStaff))
        navigationItem.rightBarButtonItem = addStaffBarButton
        
        oneLable.backgroundColor = stepOnLabelColor
        twoLabel.backgroundColor = stepOnLabelColor
        threeLabel.backgroundColor = stepOnLabelColor
        fourLabel.backgroundColor = stepOnLabelColor
        fiveLabel.backgroundColor = stepOnLabelColor
        
        cornerLabel(label: oneLable, cornerValue: Float(oneLable.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: twoLabel, cornerValue: Float(twoLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: threeLabel, cornerValue: Float(threeLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fourLabel, cornerValue: Float(fourLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fiveLabel, cornerValue: Float(fiveLabel.frame.height / 2) , maskToBounds: true)
    }
    
    @objc func addStaff () {
        nameText.isEnabled = true
        phoneText.isEnabled = true
        nameText.text = ""
        phoneText.text = ""
        rollText.text = ""
        popAnimationIn(popView: addStaffPopView)
    }
    
    @IBAction func addStaffTapped(_ sender: Any) {
        
        setMessageLanguageData(&enterstaffName, key: "Enter your staff name")
        setMessageLanguageData(&enterstaffNumber, key: "Enter your staff number")
        setMessageLanguageData(&enterStaffRoll, key: "Enter your staff roll")
        
        if (nameText.text == "") || ((nameText.text?.isEmpty)!) || (phoneText.text == "") || ((phoneText.text?.isEmpty)!) || (rollText.text == "") || ((rollText.text?.isEmpty)!){
            
            if (nameText.text == "") || ((nameText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterstaffName)
            }
            if (phoneText.text == "") || ((phoneText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterstaffNumber)
            }
            
            if (rollText.text == "") || ((rollText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterStaffRoll)
            }
        }else{
            if isEdited == true {
                isEdited = false
                showStaffList.remove(at: editIndex)
                popAnimateOut(popView: addStaffPopView)
                
                showStaffList.append(ShowIndustryStaff(id: 1, industry_id: 1, user_id: 1, role: rollText.text ??  "", name: nameText.text ?? "", phone: phoneText.text ?? "", email: "email", avatar: ShowIndustryAvatar?.none, rate: 0.0, permissions: selectedPermissionIdArr))
                
                //                manageStaffModel.append(ManageStaffDataModel(industry_id: industryID ?? 1, phone: phoneText.text ?? "", name: nameText.text ?? "", role: rollText.text ?? "", permissions: selectedPermissionIdArr))
                self.addStaffTableView.reloadData()
            }else{
                popAnimateOut(popView: addStaffPopView)
                showStaffList.append(ShowIndustryStaff(id: 1, industry_id: 1, user_id: 1, role: rollText.text ??  "", name: nameText.text ?? "", phone: phoneText.text ?? "", email: "email", avatar: ShowIndustryAvatar?.none, rate: 0.0, permissions: selectedPermissionIdArr))
                
                //                manageStaffModel.append(ManageStaffDataModel(industry_id: industryID, phone: phoneText.text ?? "", name: nameText.text ?? "", role: rollText.text ?? "" , permissions: selectedPermissionIdArr))
                //                print(manageStaffModel.count)
                //                print(manageStaffModel)
                self.addStaffTableView.reloadData()
            }
        }
    }
    
    
    
    @IBAction func saveIndustryTapped(_ sender: Any) {
        manageStaffModel.removeAll()
        for i in 0..<showStaffList.count {
            manageStaffModel.append(ManageStaffDataModel(industry_id: industryID, phone: showStaffList[i].phone ?? "", name: showStaffList[i].name ?? "", role: showStaffList[i].role ?? "", permissions: showStaffList[i].permissions))
        }
        
        manageStaffModel.remove(at: 0)
        print(manageStaffModel.count)
        print(manageStaffModel)
        loading()
        //        startActivity(view: self.view)
        let createStaffUrl = baseUrl + "staff"
        print(createStaffUrl)
        do {
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(manageStaffModel)
            jsonEncoder.outputFormatting = .prettyPrinted
            
            let url = URL(string: createStaffUrl)
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
            Alamofire.request(request).responseJSON {
                (response) in
                self.dismissLoding()
                //                stopActivity(view: self.view)
                print(response)
                print(response.response?.statusCode)
                let status = response.response?.statusCode
                
                if (response.result.value) != nil {
                    let swiftyJsonVar = JSON(response.result.value!)
                    print("create staff swiftyJsonVar ---------- ",swiftyJsonVar)
                    let status = response.response?.statusCode
                    print(status)
                    if status == 200 {
                        
                        setMessageLanguageData(&staffCreateMessage, key: "Your Staff Data Saved! Now you can manage your appointment and other settings")
                        self.displaySuccessMsg(userMsg: staffCreateMessage)
                    }
                    if status == 422 {
                        setMessageLanguageData(&staffPhonrIncorrect, key: "your Staff phone is incorrect! Please edit staff phone number")
                        self.displayAlertMsg(userMsg: staffPhonrIncorrect)
                    }
                }
            }
        }catch {
            
        }
    }
    
    @IBAction func dismissPop(_ sender: Any) {
        popAnimateOut(popView: addStaffPopView)
    }
    
    
    // ********************************** get services and Staff **********************************
    
    func getServicesandStaff(){
        loading()
        let industryUrl = baseUrl + "industries/" + "\(industryID!)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: showIndustryModel?, error:Error?,status:Int?) in
            print(status)
            self.dismissLoding()
            if status == 200 {
                let showIndustryDetails = model?.data
                print(showIndustryDetails)
                
                self.showServicesList = showIndustryDetails?.services ?? []
                //                print(self.showServicesList)
                
                self.showStaffList.removeAll()
                self.showStaffList = showIndustryDetails?.staff ?? []
                print(self.showStaffList)
                
                //                print(self.showStaffList)staff
                self.addStaffTableView.reloadData()
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    //*****************************  Add Staff list ***********************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showStaffList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let StaffCell = tableView.dequeueReusableCell(withIdentifier: "StaffTableCell", for: indexPath) as! StaffTableViewCell
        
        if indexPath.row == 0 {
            StaffCell.deleteStaffOutlet.isHidden = true
        }else{
            StaffCell.deleteStaffOutlet.isHidden = false
        }
        
        staffCellDelegate = self
        StaffCell.staffNameLabel.text = showStaffList[indexPath.row].name
        StaffCell.staffPhoneLabel.text = showStaffList[indexPath.row].phone
        
        
        StaffCell.staffPermissionsLabel.text = self.showServicesList.first {$0.id == selectedPermissionId}?.title ?? "service"
        StaffCell.stafRoolLabel.text = showStaffList[indexPath.row].role
        return StaffCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func deleteStaff(cell: UITableViewCell) {
        let index = self.addStaffTableView.indexPath(for: cell)
        indexDelete = index?.row ?? 0
        
        setMessageLanguageData(&deleteStaffMessage, key: "do you want to delete this staff")
        displayQuestionMsg(userMsg: deleteStaffMessage)
    }
    
    func editStaff(cell: UITableViewCell) {
        
        let index = self.addStaffTableView.indexPath(for: cell)
        print(index!)
        isEdited = true
        editIndex = index?.row ?? 0
        nameText.text = showStaffList[(index?.row)!].name ?? ""
        phoneText.text = showStaffList[(index?.row)!].phone ?? ""
        rollText.text = showStaffList[(index?.row)!].role ?? ""
        popAnimationIn(popView: addStaffPopView)
    }
    
    
    // ************************************ Picker *************************************
    
    func createRolePicker(){
        rolePicker.delegate = self
        rolePicker.dataSource = self
        rolePicker.backgroundColor = .lightGray
        rollText.inputView = rolePicker
        rollText.inputAccessoryView = roleToolBar
    }
    func createPermissionsPicker(){
        permissionsPicker.delegate = self
        permissionsPicker.dataSource = self
        permissionsPicker.backgroundColor = .lightGray
        permissinsText.inputView = permissionsPicker
        permissinsText.inputAccessoryView = permissionsToolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == rolePicker {
            return 1
        }
        if pickerView == permissionsPicker {
            return 1
        }
        return 1
    }
    // -------------------------------------------------------------------
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == rolePicker {
            return roleArray.count
        }
        if pickerView == permissionsPicker {
            return showServicesList.count
        }
        return 1
    }
    
    // --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == rolePicker {
            return roleArray[row]
        }
        if pickerView == permissionsPicker {
            return "\(showServicesList[row].title ?? "service")"
        }
        return ""
    }
    
    // --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("service")
        if pickerView == rolePicker {
            rollText.text = roleArray[row]
        }
        
        if pickerView == permissionsPicker {
            selectedPermissionId = showServicesList[row].id ?? 1
            selectedPermissionIdArr.append(selectedPermissionId)
            
            selectedPermissionTitle = (showServicesList.filter {$0.id == selectedPermissionId}).first?.title ?? ""
            //            selectedPermissionsTitleArr.append(selectedPermissionTitle)
            permissinsText.text = selectedPermissionTitle
            
        }
    }
    
    //********************************* ToolBar PickerView **************************
    func createRoleToolBar(){
        roleToolBar.sizeToFit()
        setMessageLanguageData(&done, key: "Done")
        let doneButton = UIBarButtonItem(title: done, style: .plain, target: self, action: #selector(dismissKeyboard))
        roleToolBar.setItems([doneButton], animated: false)
        roleToolBar.isUserInteractionEnabled = true
        roleToolBar.backgroundColor = .lightGray
        roleToolBar.tintColor = .black
    }
    func createpermissionsToolBar(){
        setMessageLanguageData(&done, key: "Done")
        permissionsToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: done, style: .plain, target: self, action: #selector(dismissKeyboard))
        permissionsToolBar.setItems([doneButton], animated: false)
        permissionsToolBar.isUserInteractionEnabled = true
        permissionsToolBar.backgroundColor = .lightGray
        permissionsToolBar.tintColor = .black
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
        
        if pickerView == rolePicker {
            lable.text = roleArray[row]
        }
        if pickerView == permissionsPicker {
            lable.text = self.showServicesList[row].title ?? ""
        }
        
        return lable
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        blackView.endEditing(true)
        addStaffPopView.endEditing(true)
    }
    
    
    //***************************** Hide KeyBoard ***********************************
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addStaffPopView.endEditing(true)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameText {
            nameText.resignFirstResponder()
        }
        if textField == rollText {
            rollText.resignFirstResponder()
        }
        if textField == phoneText {
            phoneText.resignFirstResponder()
        }
        return true
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
    
    
    // ************************************** pops Alert ***************************************
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displaySuccessMsg(userMsg: String){
        
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = myTabBar
        }))
        
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func msgDisplayError(userMsg: String){
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: "Ok", style: .default, handler: { action in
            //            self.popAnimationIn(popView: self.addStaffViewPop)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displayQuestionMsg(userMsg: String){
        setMessageLanguageData(&cancell, key: "Cancel")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        
        let myAlert = UIAlertController(title: "" ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.showStaffList.remove(at: self.indexDelete)
            self.addStaffTableView.reloadData()
        }))
        let cancelAction = (UIAlertAction(title: cancell, style: .cancel, handler: { action in
            
        }))
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated:true, completion:nil);
    }
}


var manageStaffModel   : [ManageStaffDataModel] = []


var enterstaffName = String()
var enterstaffNumber = String()
var enterStaffRoll = String()

var deleteStaffMessage  = String()
var staffCreateMessage  = String()
var staffPhonrIncorrect  = String()





