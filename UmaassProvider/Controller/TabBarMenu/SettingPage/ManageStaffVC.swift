//
//  ManageStaffVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ManageStaffVC: UIViewController, UITableViewDelegate, UITableViewDataSource, manageStaffDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var staffTableView: UITableView!
    @IBOutlet var addStaffViewPop: UIView!
    @IBOutlet weak var staffListView: UIView!
    
    @IBOutlet weak var nameText         : UITextField!
    @IBOutlet weak var roleText         : UITextField!
    @IBOutlet weak var phoneText        : UITextField!
    @IBOutlet weak var permissionText   : UITextField!
    

    
    @IBOutlet weak var manageStaffLab: UILabel!
    @IBOutlet weak var messageLab: UILabel!
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    @IBOutlet weak var roleLab: UILabel!
    @IBOutlet weak var permissionLab: UILabel!
    @IBOutlet weak var addMemberLab: UILabel!
    @IBOutlet weak var savebtn: UIButton!
    
    
    
    //    @IBOutlet var permissinsPopView: UIView!
    //    @IBOutlet weak var permissionsTableView: UITableView!
    
    var blackView             = UIView()
    var selecteRoleId         : Int?
    var permissions           = [Int]()
    var rolePicker            = UIPickerView()
    var roleToolBar           = UIToolbar()
    var permissionsPicker     = UIPickerView()
    var permissionsToolBar    = UIToolbar()
    var staffID               : Int?
    var staffRole             : String?
    var indexDelete           = Int()
    var editIndex             = Int()
    var isEdited              : Bool = false
    var selectedStaffId       = Int()
    
    var selectedPermissionId          = Int()
    var selectedPermissionIdArr       = [Int]()
    var selectedPermissionTitle       = String()
    var selectedPermissionsTitleArr   = [String]()
    
    var staffSuccessfullyUpdated = String()
    var staffSuccessfullyCreated = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(settingStaffList)
        
        setLabelLanguageData(label: manageStaffLab, key: "Manage Your Staff")
        setLabelLanguageData(label: messageLab, key: "you can always edit these")
        
        setLabelLanguageData(label: nameLab, key: "Name")
        setLabelLanguageData(label: phoneLab, key: "phone")
        setLabelLanguageData(label: roleLab, key: "role")
        setLabelLanguageData(label: permissionLab, key: "permission")
        setLabelLanguageData(label: addMemberLab, key: "Add your staff")
        
        setButtonLanguageData(button: savebtn, key: "save")
        
        setTextHintLanguageData(text: nameText, key: "Name")
        setTextHintLanguageData(text: phoneText, key: "phone")
        setTextHintLanguageData(text: roleText, key: "role")
        setTextHintLanguageData(text: permissionText, key: "permission")
        
        
//        bannerView.adUnitID = unitId
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
        
//                self.permissionsTableView.delegate = self
//                self.permissionsTableView.dataSource = self
        //        InitializerSpinner(view: self.view)
        
        setMessageLanguageData(&manageStaffPageTitle, key: "Manage Your Staff")
        self.navigationItem.title = manageStaffPageTitle
        createRolePicker()
        createRoleToolBar()
        createPermissionsPicker()
        createpermissionsToolBar()
        cornerViews(view: addStaffViewPop, cornerValue: 6.0, maskToBounds: true)
        cornerViews(view: staffListView, cornerValue: 6.0, maskToBounds: true)
        //        cornerViews(view: permissinsPopView, cornerValue: 6.0, maskToBounds: true)
        
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
        
        let addStaffBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStaff))
        navigationItem.rightBarButtonItem = addStaffBarButton
    }
    
    @objc func addStaff () {
        nameText.isEnabled = true
        phoneText.isEnabled = true
        nameText.text = ""
        phoneText.text = ""
        roleText.text = ""
        permissionText.text = ""
        popAnimationIn(popView: addStaffViewPop)
    }
    
    //*****************************  Add Staff list ***********************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == staffTableView {
            return settingStaffList.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == staffTableView {
            let staffCell = tableView.dequeueReusableCell(withIdentifier: "ManageStaffTableCell", for: indexPath) as! ManageStaffTableViewCell
            
            if indexPath.row == 0 {
                staffCell.deleteOutlet.isHidden = true
                staffCell.editOutlet.isHidden = true
            }else{
                staffCell.deleteOutlet.isHidden = false
                staffCell.editOutlet.isHidden = false
            }

            staffCell.nameLabel.text = (settingStaffList[indexPath.row].name ?? "name")
            staffCell.numberLable.text =  (settingStaffList[indexPath.row].phone ?? "number")
            staffCell.roleLable.text =  (settingStaffList[indexPath.row].role ?? "role")

            let rateNum = settingStaffList[indexPath.row].rate ?? 1.0
            print(rateNum)
            staffCell.rateView.rating = Double(rateNum)

            permissions = settingStaffList[indexPath.row].permissions ?? []
            print(permissions)

            if permissions.count > 0 {
                selectedPermissionId = permissions[0]
                staffCell.permissionLabel.text = (settingServicesList.first {$0.id == selectedPermissionId}?.title ?? "service")
            }
            staffCellDelegate = self
            return staffCell
        }
        
        //        if tableView == permissionsTableView {
        //            let permissinCell = tableView.dequeueReusableCell(withIdentifier: "PermissinsTableCell", for: indexPath) as! PermissinsTableViewCell
        //            permissinCell.serviceNameLabel.text = settingServicesList[indexPath.row].title ?? "service name"
        //
        //            return permissinCell
        //        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if tableView == permissionsTableView {
        //
        //            selectedPermissionIdArr.removeAll()
        //            selectedPermissionsTitleArr.removeAll()
        //            permissionText.text = ""
        //
        //            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
        //                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        //                selectedPermissionIdArr.remove(at: indexPath.row)
        //                selectedPermissionsTitleArr.remove(at: indexPath.row)
        //
        //            }else{
        //                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        //                selectedPermissionId = settingServicesList[indexPath.row].id ?? 1
        //                selectedPermissionIdArr.append(selectedPermissionId)
        //                selectedPermissionTitle = settingServicesList[indexPath.row].title ?? "service name"
        //                selectedPermissionsTitleArr.append(selectedPermissionTitle)
        //            }
        //            print(selectedPermissionIdArr)
        //            print(selectedPermissionsTitleArr)
        //            permissionText.text = selectedPermissionsTitleArr.joined(separator: ",")
        //        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == staffTableView {
            if indexPath.row == 0 {
                return 115
            }else{
                return 140
            }
        }
        return 140
    }
    
    func deleteStaff(cell: UITableViewCell) {
        let index = self.staffTableView.indexPath(for: cell)!
        indexDelete = index.row
        selectedStaffId = settingStaffList[(index.row)].id ?? 1
        setMessageLanguageData(&deleteStaffMessage, key: "do you want to delete this staff")
        displayQuestionMsg(userMsg: deleteStaffMessage)
    }
    
    func editStaff(cell: UITableViewCell) {
        nameText.isEnabled = false
        phoneText.isEnabled = false

        let index = self.staffTableView.indexPath(for: cell)!
        isEdited = true
        editIndex = index.row
        selectedStaffId = settingStaffList[editIndex].id ?? 1
        selectedPermissionIdArr = settingStaffList[(index.row)].permissions ?? []
        if selectedPermissionIdArr.count > 0 {
            selectedPermissionId = selectedPermissionIdArr[0]
        }
        nameText.text = settingStaffList[(index.row)].name ?? ""
        phoneText.text = settingStaffList[(index.row)].phone ?? ""
        roleText.text = settingStaffList[(index.row)].role ?? ""
        permissionText.text = (settingServicesList.first {$0.id == selectedPermissionId}?.title ?? "service")
        popAnimationIn(popView: addStaffViewPop)
    }
    
    // ********************************************** add Staff ***********************************************
    
    @IBAction func addStaffTapped(_ sender: Any) {
        
        setMessageLanguageData(&enterstaffName, key: "Enter your staff name")
        setMessageLanguageData(&enterstaffNumber, key: "Enter your staff number")
        setMessageLanguageData(&enterStaffRoll, key: "Enter your staff roll")
        
        popAnimateOut(popView: addStaffViewPop)
        if (nameText.text == "") || ((nameText.text?.isEmpty)!) || (phoneText.text == "") || ((phoneText.text?.isEmpty)!) || (roleText.text == "") || ((roleText.text?.isEmpty)!){

            if (nameText.text == "") || ((nameText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterstaffName)
            }
            if (phoneText.text == "") || ((phoneText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterstaffNumber)
            }

            if (roleText.text == "") || ((roleText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterStaffRoll)
            }
        }else{
            //            startActivity(view: self.view)
            if isEdited == true {
                isEdited = false
                //                manageStaffModel.append(ManageStaffDataModel(industry_id: industryID ?? 1, phone: (phoneText.text ?? ""), name: (nameText.text ?? ""), role: (roleText.text ?? ""), permissions: (selectedPermissionIdArr)))
                self.saveChange()
            }else{
                manageStaffModel.removeAll()
                manageStaffModel.append(ManageStaffDataModel(industry_id: industryID ?? 1, phone: (phoneText.text ?? ""), name: (nameText.text ?? ""), role: (roleText.text ?? ""), permissions: (selectedPermissionIdArr)))
                self.createStaff()
            }
        }
    }
    
    
    @IBAction func dismissttaped(_ sender: Any) {
        
        popAnimationIn(popView: addStaffViewPop)
        //        popAnimateOut(popView: permissinsPopView)
    }
    
    
    var updateStaffUrl = String()
    var permissionSurl = String()
    
    func saveChange() {
        loading()
        let baseurll = baseUrl + "staff/" + "\(selectedStaffId)"
        let industryIdUrl = "?industry_id=" + "\(industryID ?? 1)"
        let roleUrl = "&role=" + (roleText.text ?? "admin")
        let permissionUrl = "&permissions%5B%5D=" + "\(selectedPermissionId)"

        //        for i in 0..<selectedPermissionIdArr.count {
        //            let s = "&permissions%5B%5D=" + "\(selectedPermissionIdArr[i])"
        //            permissionSurl = permissionSurl + s
        //            print(permissionSurl)
        //        }

        let finalUr = baseurll + industryIdUrl + roleUrl + permissionUrl

        if finalUr.contains(" ") {
            updateStaffUrl = finalUr.replacingOccurrences(of: " ", with: "%20")
        }else{
            updateStaffUrl = finalUr
        }

        print(updateStaffUrl)
        var headers:HTTPHeaders = [
            "Authorization": "Bearer \(accesssToken)",
            "X-Requested-With": "application/json",
            "Content-type" : "application/json",
            "Accept" : "application/json"
        ]

        Alamofire.request(updateStaffUrl, method: .put, headers: headers).responseJSON { response in
            self.dismissLoding()
            if let value: AnyObject = response.result.value as AnyObject? {
                let post = JSON(value)
                print(post)

                let status = response.response?.statusCode
                print(status)

                let data = post["data"].dictionary
                let message = data?["message"]?.stringValue
                if status == 200 {
                    print("ok")
                    
                    setMessageLanguageData(&self.staffSuccessfullyUpdated, key: "Your Staff Successfully Updated")
                    self.displaySuccessMsg(userMsg: self.staffSuccessfullyUpdated)
                }else{
                    setMessageLanguageData(&someThingWentWrong, key: "SomeThing went wrong")
                    self.displayAlertMsg(userMsg: message ?? someThingWentWrong)
                }
            }
        }
    }

    // ********************************************** save Staff ******************************************
    
    func createStaff(){
        loading()
        print(manageStaffModel)
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
//                print(response)

                if (response.result.value) != nil {
                    let swiftyJsonVar = JSON(response.result.value!)
                    print("create staff swiftyJsonVar ---------- ",swiftyJsonVar)

                    let status = response.response?.statusCode
//                    print(status)
                    if status == 200 {
                        setMessageLanguageData(&self.staffSuccessfullyCreated, key: "staff successfuly created")
                        self.displaySuccessMsg(userMsg: self.staffSuccessfullyCreated)
                    }
                    if status == 422 {
                        self.popAnimateOut(popView: self.addStaffViewPop)
                        setMessageLanguageData(&staffPhonrIncorrect, key: "your Staff phone is incorrect")
                        self.msgDisplayError(userMsg: staffPhonrIncorrect)
                    }
                }else{
                    let message = swiftyJsonVar["data"].string
                    setMessageLanguageData(&someThingWentWrong, key: "SomeThing went wrong")
                    self.displayAlertMsg(userMsg: message ?? someThingWentWrong)
                }
            }
        }catch {

        }
    }
    
    @IBAction func dismissPop(_ sender: Any) {
        popAnimateOut(popView: addStaffViewPop)
    }
    
    // ************************************ Picker *************************************
    
    func createRolePicker(){
        rolePicker.delegate = self
        rolePicker.dataSource = self
        rolePicker.backgroundColor = .lightGray
        roleText.inputView = rolePicker
        roleText.inputAccessoryView = roleToolBar
    }
    
    func createPermissionsPicker(){
        permissionsPicker.delegate = self
        permissionsPicker.dataSource = self
        permissionsPicker.backgroundColor = .lightGray
        permissionText.inputView = permissionsPicker
        permissionText.inputAccessoryView = permissionsToolBar
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
            return settingServicesList.count
        }
        
        return 1
    }
    
    // --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == rolePicker {
            return roleArray[row]
        }
        if pickerView == permissionsPicker {
            return settingServicesList[row].title ?? "service"
        }
        return ""
    }
    
    // --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("service")
        
        if pickerView == rolePicker {
            roleText.text = roleArray[row]
        }

        if pickerView == permissionsPicker {
            if settingServicesList.count > 0 {
                selectedPermissionId = settingServicesList[row].id ?? 1
                selectedPermissionIdArr.append(selectedPermissionId)
                selectedPermissionTitle = (settingServicesList.filter {$0.id == selectedPermissionId}).first?.title ?? ""
                permissionText.text = selectedPermissionTitle
            }
        }
    }
    
    //--------------------------------------------------------------------
    func createRoleToolBar(){
        setMessageLanguageData(&done, key: "Done")
        roleToolBar.sizeToFit()
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
            lable.text = settingServicesList[row].title ?? "service"
        }
        return lable
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        blackView.endEditing(true)
        addStaffViewPop.endEditing(true)
    }
    
    //***************************** Hide KeyBoard ***********************************
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.blackView.endEditing(true)
        self.addStaffViewPop.endEditing(true)
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameText {
            nameText.resignFirstResponder()
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
    
    func displayQuestionMsg(userMsg: String){
        setMessageLanguageData(&cancell, key: "Cancel")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: "" ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            settingStaffList.remove(at: self.indexDelete)
            self.deleteStaff()
        }))
        let cancelAction = (UIAlertAction(title: cancell, style: .cancel, handler: { action in
            
        }))
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    func displaySuccessMsg(userMsg: String){
        
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.getStaff()
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func msgDisplayError(userMsg: String){
        
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.popAnimationIn(popView: self.addStaffViewPop)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
// ********************************** get staff  **********************************
    
    func getStaff(){
        loading()
        let industryUrl = baseUrl + "industries/" + "\(industryID!)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: showIndustryModel?, error:Error?,status:Int?) in
            print(status)
            self.dismissLoding()
            if status == 200 {
                let showIndustryDetails = model?.data
                print(showIndustryDetails)

                settingStaffList = showIndustryDetails?.staff ?? []
                print(settingStaffList)
                self.staffTableView.reloadData()
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
// ********************************** delete staff  **********************************
    
    func deleteStaff() {
        loading()
        let industryUrl = baseUrl + "staff/" + "\(selectedStaffId)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .delete, isHeaders: true) { (model: MessageModel?, error:Error?,status:Int?) in
            print(status)
            self.dismissLoding()
            if status == 200 {
                setMessageLanguageData(&successfullyDeleted, key: "staff successfuly deleted")
                self.displaySuccessMsg(userMsg: successfullyDeleted)
                self.staffTableView.reloadData()
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                let errorMessage = model?.data?.message ?? someThingWentWrong
                self.displayAlertMsg(userMsg: errorMessage)
            }
        }
    }
}



var successfullyDeleted = String()
