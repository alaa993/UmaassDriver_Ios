//
//  EditIndustryVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class EditIndustryVC: UIViewController, UITextFieldDelegate, UITextViewDelegate,DelegateCity,DelegateCountry {

    @IBOutlet weak var mainView            : UIView!
    @IBOutlet weak var scrollView          : UIScrollView!
    
    @IBOutlet weak var titleText            : UITextField!
    @IBOutlet weak var addressText           : UITextField!
    @IBOutlet weak var bioText      : UITextView!
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var bioLab: UILabel!
    @IBOutlet weak var addressLab: UILabel!
    
    var passedTitle      : String?
    var passedAddress    : String?
    var passedbio        : String?
    
    
    var cityModel:CityIndustryModel?
     
     @IBOutlet var label_country: UILabel!
     @IBOutlet var label_city: UILabel!
     @IBOutlet var textField: UITextField!
     @IBOutlet var textField_country: UITextField!
     
     var cityId = 0
     var countryId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textField.delegate = self
        textField_country.delegate = self
        
        label_city.text = setMessage(key: "Enter your city")
        textField.placeholder = setMessage(key: "Enter your city")
        label_country.text = setMessage(key: "Select country")
        textField_country.placeholder = setMessage(key: "Select country")
        
        
        
        setLabelLanguageData(label: titleLab, key: "title")
        setLabelLanguageData(label: bioLab, key: "your bio")
        setLabelLanguageData(label: addressLab, key: "Address")
        
        setTextHintLanguageData(text: titleText, key: "title")
        setTextHintLanguageData(text: addressText, key: "Address")
//        setTextHintLanguageData(text: bioText, key: "")
        
        // ------------- banner view --------------

        
        
        setMessageLanguageData(&editIndustryPageTitle, key: "Edit Industry")
        self.navigationItem.title = editIndustryPageTitle
        
        cornerViews(view: mainView, cornerValue: 6.0, maskToBounds: true)
        bioText.layer.cornerRadius = 6.0
        bioText.layer.masksToBounds = true
        
        
        setMessageLanguageData(&navigationSave, key: "save")
        let saveEdit = UIBarButtonItem(title: navigationSave, style: .plain, target: self, action: #selector(saveIndustry))
        navigationItem.rightBarButtonItem = saveEdit
        
        titleText.text = passedTitle
        if passedbio == "" {
            self.bioText.text = "Your Bio ..."
            self.bioText.textColor = UIColor.lightGray
        }else{
            bioText.text = passedbio
            self.bioText.textColor = UIColor.black
        }
        
        if cityModel != nil {
            
             cityId = cityModel?.id ?? 0
             countryId = cityModel?.country_id ?? 0
             textField.text = cityModel?.name
             textField_country.text = cityModel?.country_name
        }
        
        addressText.text = passedAddress
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    
    
    var updateProfileUrl = String()
    var finalUrl = String()
    @objc func saveIndustry() {
        loading()
        
        var titleTxt = (titleText?.text ?? "")
        if let encodText = titleTxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            print(encodText)
            titleTxt = encodText
        }
        
        var addressTxt = (addressText?.text ?? "")
        if let encodText = addressTxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            print(encodText)
            addressTxt = encodText
        }
        
        var bioTxt = (bioText?.text ?? "")
        if let encodText = bioTxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            print(encodText)
            bioTxt = encodText
        }
        
        
        let baseurll = baseUrl + "industries/" + "\(industryID ?? 1)"
        let firstUrl = "?address=" + addressTxt + "&description=" + bioTxt
        let secnUrl = "&title=" + titleTxt
        
        let city_id = "&city_id=\(cityId)"
        let finalUr = baseurll + firstUrl + secnUrl + city_id
        
        
        if finalUr.contains(" ")  {
            finalUrl = finalUr.replacingOccurrences(of: " ", with: "%20")
        }else{
            finalUrl = finalUr
        }
        
        print(finalUrl)
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(accesssToken)",
            "X-Requested-With": "application/json",
            "Content-type" : "application/json",
            "Accept" : "application/json"
        ]
        
        Alamofire.request(finalUrl, method: .put, headers: headers).responseJSON { response in
            self.dismissLoding()
            if let value: AnyObject = response.result.value as AnyObject? {
                let post = JSON(value)
                print(post)
                let status = response.response?.statusCode
                let data = post["data"].dictionary
                let message = data?["message"]?.stringValue
         
                if status == 200 {
                    setMessageLanguageData(&industryUpdated, key: "Your Industry Successfully Updated")
                    self.displaySuccessMsg(userMsg:  industryUpdated)
                }else if status == 401 {
                    setMessageLanguageData(&someThingWentWrong, key: "someThing went wrong")
                    let message = swiftyJsonVar["message"].string
                    self.displayAlertMsg(userMsg: message ?? someThingWentWrong)
                }else if status == 500 {
                    setMessageLanguageData(&wrongAccess, key: "Wrong access token")
                    self.displayAlertMsg(userMsg: wrongAccess)
                }
                else {
                    setMessageLanguageData(&someThingWentWrong, key: "someThing went wrong")
                    self.displayAlertMsg(userMsg: message ?? "SomeThing went wrong!")
                }
            }
        }
    }
    
    //***************************** Hide KeyBoard ***********************************
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scrollView.endEditing(true)
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0...1:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x: 0, y: 20), animated: true)
        case 3 :
            intentCountry()
        case 4 :
            intentCity()
            
        default:
            print("ok")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleText {
            titleText.resignFirstResponder()
        }
        if textField == addressText {
            addressText.resignFirstResponder()
        }
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        switch textView.tag {
        case 0...1:
            print("ok")
        default:
            scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if bioText.textColor == UIColor.lightGray && bioText.isFirstResponder {
            bioText.text = ""
            bioText.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if bioText.text.isEmpty || bioText.text == "" {
            bioText.textColor = UIColor.lightGray
            bioText.text = "Your Bio ..."
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            bioText.resignFirstResponder()
            return false
        }
        return true
    }
    
    // ---------------------------- display alert ---------------------------
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
            self.navigationController?.popViewController(animated: true)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    @objc func intentCity(){
        if countryId == 0 {
            displayAlertMsg(userMsg: setMessage(key: "Please first select the country"))
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCCity") as! VCCity
            vc.id = countryId
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func intentCountry(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCCountry") as! VCCountry
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func city(model: CityData) {
        
        textField.text = model.name ?? ""
        cityId = model.id ?? 0
    }
    
    func country(country: ProvineData) {
        textField_country.text = country.name ?? ""
        countryId = country.id ?? 0
    }
}

var industryUpdated = String()
