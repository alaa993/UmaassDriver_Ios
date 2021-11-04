//
//  SwitchIndustryVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/10/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import CoreData


class SwitchIndustryVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var selectText           : UITextField!
    @IBOutlet weak var nextOutlet           : UIButton!
    
    @IBOutlet weak var selectIndustryLab: UILabel!
    
    
    var industryPicker         = UIPickerView()
    var industryToolBar        = UIToolbar()
    var passeIsLogin           : Bool = false
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: selectIndustryLab, key: "Select your industry")
        setButtonLanguageData(button: nextOutlet, key: "Next")
        setTextHintLanguageData(text: selectText, key: "Select your industry")
        
        print(industryList)
        
        selectIndustryToolBar()
        selectIndustryPicker()
        cornerButton(button: nextOutlet, cornerValue: 6.0, maskToBounds: true)
        
        setMessageLanguageData(&selectIndustry, key: "Select your industry")
        self.navigationItem.title = selectIndustry
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if passeIsLogin == true {
            self.navigationItem.hidesBackButton = true
            passeIsLogin = false
        }else{
            selectText.isHidden = true
            getAllIndustry()
        }
    }
    
    
// *************************************** get industries *****************************************
    func getAllIndustry(){
        loading()
        let industryUrl = baseUrl + "industries?mine=true"
        print(industryUrl)
        print(accesssToken)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: MyIndustryModel?, error:Error?,status:Int?) in
            print(status)
            self.dismissLoding()
            if status == 200 {
                industryList = model?.data ?? []
                print(industryList)
                if industryList.count > 0 {
                    self.selectText.isHidden = false
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    
    
    
    func saveIndustryId(id: Int) {
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Industry", into: context)
        newUser.setValue(id, forKey: "industryId")
        do{
            try context.save()
            print("saved industryId: \(String(describing: industryID))")
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = myTabBar
        }catch{
            //
        }
    }
    
    // ************************************ Picker *************************************
    func selectIndustryPicker(){
        industryPicker.delegate = self
        industryPicker.dataSource = self
        industryPicker.backgroundColor = .lightGray
        selectText.inputView = industryPicker
        selectText.inputAccessoryView = industryToolBar
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // -------------------------------------------------------------------
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return industryList.count
    }
    
    // --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return industryList[row].title ?? ""
    }
    
    // --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectText.text = industryList[row].title ?? ""
        industryID = industryList[row].id
        print(industryID ?? 0)
        
    }
    
    //********************************* ToolBar PickerView **************************
    
    func selectIndustryToolBar(){
        industryToolBar.sizeToFit()
        setMessageLanguageData(&done, key: "Done")
        let doneButton = UIBarButtonItem(title: done ,style: .plain, target: self, action: #selector(dismissKeyboard))
        industryToolBar.setItems([doneButton], animated: false)
        industryToolBar.isUserInteractionEnabled = true
        industryToolBar.backgroundColor = .lightGray
        industryToolBar.tintColor = .black
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var lable: UILabel
        if let view = view as? UILabel{
            lable = view
        }else {
            lable = UILabel()
        }
        if row == 0 {
            selectText.text = industryList[row].title ?? ""
            industryID = industryList[row].id
        }
        
        lable.textColor     = .black
        lable.textAlignment = .center
        lable.text = industryList[row].title ?? ""
        return lable
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        if (selectText.text == "") || ((selectText.text?.isEmpty)!) {
            setMessageLanguageData(&selectIndustry, key: "Select your industry")
            self.displayAlertMsg(userMsg: selectIndustry)
        }else{
            saveIndustryId(id: industryID ?? 1)
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

var selectIndustry = String()
