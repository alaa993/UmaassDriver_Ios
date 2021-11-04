//
//  IndustryVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

class IndustryVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate, UITextFieldDelegate ,DelegateCity,DelegateCountry{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var industryText: UITextField!
    @IBOutlet weak var bussinessText: UITextField!
//    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    
     @IBOutlet var label_Contry: UILabel!
     @IBOutlet var textField_Country: UITextField!
    
    @IBOutlet weak var oneLable: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    
    @IBOutlet weak var categLab: UILabel!
    @IBOutlet weak var businessLab: UILabel!
    @IBOutlet weak var cityLab: UILabel!
    @IBOutlet weak var addressLab: UILabel!
    @IBOutlet weak var wellcomeLab: UILabel!
    @IBOutlet weak var mesageLab: UILabel!
    
    
    
    @IBOutlet weak var nextBtnOutlet: UIButton!
    
    var categoryList                   = [categoryData]()
    var selectedIndustryId             : Int?

    var cityList                       = [CityData]()
    var industryPicker         = UIPickerView()
    var industryToolBar        = UIToolbar()
    
    var cityPicker             = UIPickerView()
    var cityToolBar            = UIToolbar()
    
    var cityId = 0
    var countryId = 0
    
//    var countryPicker          = UIPickerView()
//    var countryToolBar         = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label_Contry.text = setMessage(key: "Select country")
        textField_Country.placeholder = setMessage(key: "Select country")
        
        setLabelLanguageData(label: categLab, key: "category")
        setLabelLanguageData(label: businessLab, key: "your business")
        setLabelLanguageData(label: cityLab, key: "City")
        setLabelLanguageData(label: addressLab, key: "Address")
        setLabelLanguageData(label: wellcomeLab, key: "Welcome to Umaass Provider")
        setLabelLanguageData(label: mesageLab, key: "We'll get you booking appointments in no time Next")
        
        setLabelLanguageData(label: welcomeLabel, key: "Welcome")
        setLabelLanguageData(label: mapLabel, key: "location")
        setLabelLanguageData(label: hoursLabel, key: "hours")
        setLabelLanguageData(label: staffLabel, key: "staff")
        setLabelLanguageData(label: serviceLabel, key: "Service")
        
        setTextHintLanguageData(text: industryText, key: "Select your industry")
        setTextHintLanguageData(text: bussinessText, key: "Enter your business Title")
        setTextHintLanguageData(text: cityText, key: "Enter your city")
        setTextHintLanguageData(text: addressText, key: "Enter your business address")
        
        setButtonLanguageData(button: nextBtnOutlet, key: "Next")
        
        
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
        
        
        setMessageLanguageData(&industyrPageTitle, key: "Industry")
        self.navigationItem.title = industyrPageTitle
        
        
        createIndustryPicker()
        createIndustryToolBar()
        
    //    createCityPicker()
        createCityToolBar()
//        createCountryPicker()
//        createCountryToolBar()
        
        getAllCategory()
      //  getCities()
//
        oneLable.backgroundColor = stepOnLabelColor
        twoLabel.backgroundColor = stepOffLabelColor
        threeLabel.backgroundColor = stepOffLabelColor
        fourLabel.backgroundColor = stepOffLabelColor
        fiveLabel.backgroundColor = stepOffLabelColor
        
        cornerLabel(label: oneLable, cornerValue: Float(oneLable.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: twoLabel, cornerValue: Float(twoLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: threeLabel, cornerValue: Float(threeLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fourLabel, cornerValue: Float(fourLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fiveLabel, cornerValue: Float(fiveLabel.frame.height / 2) , maskToBounds: true)
        
        cornerButton(button: nextBtnOutlet, cornerValue: 6.0, maskToBounds: true)
        
        textField_Country.delegate = self
        cityText.delegate = self
    }
    
    func getAllCategory() {
        loading()
        
        var categoryUrl = String()
        if resourceKey == "ckb" {
            categoryUrl = "http://umaass.com/api/categories?lang=ku"
        }else{
            categoryUrl = "http://umaass.com/api/categories?lang=" + resourceKey
        }
        
        ServiceAPI.shared.fetchGenericData(urlString: categoryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: categoryModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            //            stopActivity(view: self.view)
            print(categoryUrl)
            print(status)
            if status == 200 {
                self.categoryList = model?.data ?? []
                //                print(self.categoryList)
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }

    func getCities() {
        loading()
        let cityUrl = baseUrl + "cities"
        print(cityUrl)
        ServiceAPI.shared.fetchGenericData(urlString: cityUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: cityModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            print(status)
            if status == 200 {
                self.cityList = model?.data ?? []
                print(self.cityList)
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }

    
    
    @IBAction func nextToMapTapped(_ sender: Any) {
        
        setMessageLanguageData(&enterYourBusinessTitle, key: "Enter your business Title")
        setMessageLanguageData(&enterYourCity, key: "Enter your city")
        setMessageLanguageData(&enterYourBusinessAddress, key: "Enter your business address")
        
        
        if (bussinessText.text == "") || ((bussinessText.text?.isEmpty)!) || (cityText.text == "") || ((cityText.text?.isEmpty)!) || (addressText.text == "") || ((addressText.text?.isEmpty)!) {
            
            if (bussinessText.text == "") || ((bussinessText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterYourBusinessTitle)
            }
            if (cityText.text == "") || ((cityText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterYourCity)
            }
            if (addressText.text == "") || ((addressText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterYourBusinessAddress)
            }
        }else{
            bussinesTitle = bussinessText.text ?? ""
            selectedCityId = cityId
            bussinesAddress = addressText.text ?? ""
            performSegue(withIdentifier: "toMap", sender: self)
        }
    }
    
    
    
// ************************************ Picker *************************************
    
    func createIndustryPicker(){
        industryPicker.delegate = self
        industryPicker.dataSource = self
        industryPicker.backgroundColor = .lightGray
        industryText.inputView = industryPicker
        industryText.inputAccessoryView = industryToolBar
    }
    
    func createCityPicker(){
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityPicker.backgroundColor = .lightGray
        cityText.inputView = cityPicker
        cityText.inputAccessoryView = cityToolBar
    }
    
//    func createCountryPicker(){
//        countryPicker.delegate = self
//        countryPicker.dataSource = self
//        countryPicker.backgroundColor = .lightGray
//        countryText.inputView = countryPicker
//        countryText.inputAccessoryView = countryToolBar
//    }
    
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

        cityText.text = model.name ?? ""
        cityId = model.id ?? 0
    }
    
    func country(country: ProvineData) {
        textField_Country.text = country.name ?? ""
        countryId = country.id ?? 0
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == industryPicker {
            return 1
        }
        if pickerView == cityText {
            return 1
        }
        return 1
    }
// -------------------------------------------------------------------
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == industryPicker {
            return categoryList.count
        }
        if pickerView == cityPicker {
            return cityList.count
        }
        return 1
    }
    
// --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == industryPicker {
            return categoryList[row].name
        }
        if pickerView == cityPicker {
            return cityList[row].name
        }
        return ""
    }
    
// --------------------------------------------------------------------
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == industryPicker {
            industryText.text = categoryList[row].name
            selectedCategoryId = categoryList[row].id
            print(selectedIndustryId ?? 0)
        }
        if pickerView == cityPicker {
            cityText.text = cityList[row].name
            selectedCityId = cityList[row].id
        }
    }
    
//********************************* ToolBar PickerView **************************
    
    func createIndustryToolBar(){
        setMessageLanguageData(&done, key: "Done")
        industryToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: done, style: .plain, target: self, action: #selector(dismissKeyboard))
        industryToolBar.setItems([doneButton], animated: false)
        industryToolBar.isUserInteractionEnabled = true
        industryToolBar.backgroundColor = .lightGray
        industryToolBar.tintColor = .black
    }
    func createCityToolBar(){
        setMessageLanguageData(&done, key: "Done")
        cityToolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: done, style: .plain, target: self, action: #selector(dismissKeyboard))
        cityToolBar.setItems([doneButton], animated: false)
        cityToolBar.isUserInteractionEnabled = true
        cityToolBar.backgroundColor = .lightGray
        cityToolBar.tintColor = .black
    }
    
//    func createCountryToolBar(){
//        countryToolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
//        countryToolBar.setItems([doneButton], animated: false)
//        countryToolBar.isUserInteractionEnabled = true
//        countryToolBar.backgroundColor = .lightGray
//        countryToolBar.tintColor = .black
//    }
//    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var lable: UILabel
        if let view = view as? UILabel{
            lable = view
        }else {
            lable = UILabel()
        }
        
        lable.textColor     = .black
        lable.textAlignment = .center
                lable.font = UIFont(name: "IRANSansWeb-Bold", size: 13.0)
        if pickerView == industryPicker {
            lable.text = categoryList[row].name
        }
        if pickerView == cityPicker {
            lable.text = cityList[row].name
        }
        return lable
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
//***************************** Hide KeyBoard ***********************************
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scrollView.endEditing(true)
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            scrollView.setContentOffset(CGPoint(x: 0, y: 40), animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        case 2:
            intentCountry()  
        case 3:
            intentCity()
        default:
            scrollView.setContentOffset(CGPoint(x: 0, y: 170), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == bussinessText {
            bussinessText.resignFirstResponder()
        }
        if textField == cityText {
            cityText.resignFirstResponder()
        }
        if textField == addressText {
            addressText.resignFirstResponder()
        }
        return true
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


// --------------- variable -----------------
var selectedCategoryId    : Int?
var bussinesTitle         : String?
var bussinessPhone        : String?
var bussinesAddress       : String?
var city                  : String?
var selectedCityId        : Int?
var businessLat           : Double?
var businessLng           : Double?

var enterYourBusinessTitle = String()
var enterYourCity = String()
var enterYourBusinessAddress = String()
