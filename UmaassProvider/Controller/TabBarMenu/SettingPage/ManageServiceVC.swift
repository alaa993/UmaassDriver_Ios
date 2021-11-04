//
//  ManageServiceVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class ManageServiceVC: UIViewController, UITableViewDelegate, UITableViewDataSource, manageServiceDelegate, UITextFieldDelegate {

    @IBOutlet weak var serviceTableView     : UITableView!
    @IBOutlet var addServiceViewPop         : UIView!
    @IBOutlet weak var servicenameText      : UITextField!
    @IBOutlet weak var servicePriceText     : UITextField!
    @IBOutlet weak var serviceTimeText      : UITextField!
    @IBOutlet weak var serviceView          : UIView!

    @IBOutlet weak var serviceTimeType: UITextField!
    
    @IBOutlet weak var servicePriceTime: UITextField!
    @IBOutlet weak var manageServiceLab: UILabel!
    @IBOutlet weak var messageLab: UILabel!
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var addServiceLab: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    
    var serviceId             : String?
    var blackView             = UIView()
    var indexDelete           = Int()
    var editIndex             = Int()
    var selectedSerId         = Int()
    var isEdited              : Bool = false
    var servName              = String()
    var priceStr              = String()
    var NumberStr              = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelLanguageData(label: manageServiceLab, key: "add the services you offer")
        setLabelLanguageData(label: messageLab, key: "you can always edit these")
        
        setLabelLanguageData(label: nameLab, key: "Name")
        setLabelLanguageData(label: priceLab, key: "price")
        setLabelLanguageData(label: timeLab, key: "time duration")
        setLabelLanguageData(label: addServiceLab, key: "Add  services")
        
        
        
        setButtonLanguageData(button: addBtn, key: "add")
        
        setTextHintLanguageData(text: servicenameText, key: "Name")
        setTextHintLanguageData(text: servicePriceText, key: "price")
        setTextHintLanguageData(text: serviceTimeText, key: "time duration")
        
        
        // ------------- banner view --------------
//        bannerView.adUnitID = unitId
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
        
        
        setMessageLanguageData(&manageServicePageTitle, key: "Services")
        self.navigationItem.title = manageServicePageTitle
        
        cornerViews(view: addServiceViewPop, cornerValue: 6.0, maskToBounds: true)
        cornerViews(view: serviceView, cornerValue: 6.0, maskToBounds: true)
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
        
        let addServiceBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addService))
        navigationItem.rightBarButtonItem = addServiceBtn
    }
    
    @objc func addService () {
        servicenameText.text = ""
        servicePriceText.text = ""
        serviceTimeText.text = ""
        popAnimationIn(popView: addServiceViewPop)
    }
    
//*****************************  Add Staff list ***********************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingServicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let serviceCell = tableView.dequeueReusableCell(withIdentifier: "ManageServiceTableCell", for: indexPath) as! ManageServiceTableViewCell
        serviceCellDelegate = self
        
        if indexPath.row == 0 {
            serviceCell.deleteOutlet.isHidden = true
        }else{
            serviceCell.deleteOutlet.isHidden = false
        }

        serviceCell.serviceName.text = (settingServicesList[indexPath.row].title ?? "")
        serviceCell.servicePrice.text = "\(settingServicesList[indexPath.row].price ?? 10)" + "\(settingServicesList[indexPath.row].TypePrice ?? " $")"
        serviceCell.serviceTime.text = "\(settingServicesList[indexPath.row].duration ?? 10)" + "\(settingServicesList[indexPath.row].TypeTime ?? " min")"
        
        return serviceCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func deleteService(cell: UITableViewCell) {
        let index = serviceTableView.indexPath(for: cell)!
        indexDelete = index.row
        print(indexDelete)
        selectedSerId = settingServicesList[(index.row)].id ?? 1
        print(selectedSerId)
        
        setMessageLanguageData(&deleteServiceMessage, key: "do you want to delete this service")
        displayQuestionMsg(userMsg: deleteServiceMessage)
    }
    
    func editService(cell: UITableViewCell) {
        let index = self.serviceTableView.indexPath(for: cell)!
        print(index)
        isEdited = true
        editIndex = index.row
        print(editIndex)
        selectedSerId = settingServicesList[(index.row)].id ?? 1
        print(selectedSerId)
        servicenameText.text = settingServicesList[(index.row)].title ?? ""
        servicePriceText.text = "\(settingServicesList[(index.row)].price ?? 10)"
        serviceTimeText.text = "\(settingServicesList[(index.row)].duration ?? 10)"
        popAnimationIn(popView: addServiceViewPop)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        setMessageLanguageData(&enterServiceName, key: "Enter service name")
        setMessageLanguageData(&enterServicePrice, key: "Enter service price")
        setMessageLanguageData(&enterServiceTime, key: "Enter service time duration")
        
        popAnimateOut(popView: addServiceViewPop)
        if (servicenameText.text == "") || ((servicenameText.text?.isEmpty)!) || (servicePriceText.text == "") || ((servicePriceText.text?.isEmpty)!) || (serviceTimeText.text == "") || ((serviceTimeText.text?.isEmpty)!) {

            if (servicenameText.text == "") || ((servicenameText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterServiceName)
            }
            if (servicePriceText.text == "") || ((servicePriceText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterServicePrice)
            }
            if (serviceTimeText.text == "") || ((serviceTimeText.text?.isEmpty)!) {
                displayAlertMsg(userMsg: enterServiceTime)
            }

        }else{
            loading()
            servName = self.servicenameText.text ?? "service name"
            if let encodText = servName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                print(encodText)
                servName = encodText
            }
            
            NumberStr = self.serviceTimeText.text ?? "10"
            let Formatter = NumberFormatter()
            Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            if let final = Formatter.number(from: NumberStr) {
                print(final)
                NumberStr = "\(final)"
                print(NumberStr)
            }
            let typeTime = self.serviceTimeType.text ?? "min"
            let typePrice = self.servicePriceTime.text ?? "$"
            priceStr = self.servicePriceText.text ?? "10"
            Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            if let final = Formatter.number(from: priceStr) {
                print(final)
                priceStr = "\(final)"
                print(priceStr)
            }
            if isEdited == true {
                isEdited = false
                popAnimateOut(popView: addServiceViewPop)

                ManageServiceModel.append(ManageServiceDataModel(industry_id: industryID ?? 1, title: servName, duration: Int(NumberStr), price: Int(priceStr), notes_for_the_customer: "notes",TypeTime: typeTime,TypePrice: typePrice))

                self.saveChange()
            }else{
                popAnimateOut(popView: addServiceViewPop)
                ManageServiceModel.removeAll()
                ManageServiceModel.append(ManageServiceDataModel(industry_id: industryID ?? 1, title: servicenameText.text ?? "", duration: Int(NumberStr), price: Int(priceStr), notes_for_the_customer: "notes",TypeTime: typeTime,TypePrice: typePrice))

                self.createService()

            }
        }
    }
    
    
    var updateServiceUrl = String()
    func saveChange() {
        let baseurll = baseUrl + "services/" + "\(selectedSerId)"
        let titleUrl = "?title=" + (servName)
        let durationUrl = "&duration=" + "\(Int(NumberStr) ?? 10)"
        let priceUrl = "&price=" + "\(Int(priceStr) ?? 10)"
        let otherUrl = "&notes_for_the_customer=noteeee%20comes%20here"

        let finalUr = baseurll + titleUrl + durationUrl + priceUrl + otherUrl

        if finalUr.contains(" ") {
            updateServiceUrl = finalUr.replacingOccurrences(of: " ", with: "%20")
        }else{
            updateServiceUrl = finalUr
        }

        print(accesssToken)
        var headers:HTTPHeaders = [
            "Authorization": "Bearer \(accesssToken)",
            "X-Requested-With": "application/json",
            "Content-type" : "application/json",
            "Accept" : "application/json"
        ]

        Alamofire.request(updateServiceUrl, method: .put, headers: headers).responseJSON { response in
            self.dismissLoding()
            if let value: AnyObject = response.result.value as AnyObject? {
                let post = JSON(value)
                print(post)

                let status = response.response?.statusCode
//                print(status)

                if status == 200 {
                    print("ok")
                    setMessageLanguageData(&serviceUpdated, key: "Your Service Successfully Updated")
                    self.displaySuccessMsg(userMsg: serviceUpdated)
                }
                if status == 422 {
                    setMessageLanguageData(&invalidData, key: "Invalid data")
                    self.displayAlertMsg(userMsg: invalidData)
                }
            }
        }
    }


    func createService() {

        print(ManageServiceModel)
        let addServiceUrl = baseUrl + "services"
        print(addServiceUrl)
        do {

            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(ManageServiceModel)
            jsonEncoder.outputFormatting = .prettyPrinted

            let url = URL(string: addServiceUrl)
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
                print(response)
//                 print(response.response?.statusCode)
                let status = response.response?.statusCode

                if (response.result.value) != nil {
                    let swiftyJsonVar = JSON(response.result.value!)
                    print("create service swiftyJsonVar ---------- ",swiftyJsonVar)
                    
                    let status = response.response?.statusCode
                    if status == 200 {
                        setMessageLanguageData(&serviceCreateMessage, key: "your services create successfully")
                        self.displaySuccessMsg(userMsg: serviceCreateMessage)
                    }
                    else{
                        setMessageLanguageData(&invalidData, key: "Invalid data")
                        self.displayAlertMsg(userMsg: invalidData)
                    }

                }
            }
        }catch {

        }
    }

    
    @IBAction func dismissPop(_ sender: Any) {
        isEdited = false
        popAnimateOut(popView: addServiceViewPop)
    }
    
    //***************************** Hide KeyBoard ***********************************
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.blackView.endEditing(true)
        self.addServiceViewPop.endEditing(true)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == servicenameText {
            servicenameText.resignFirstResponder()
        }
        if textField == servicePriceText {
            servicePriceText.resignFirstResponder()
        }
        if textField == serviceTimeText {
            serviceTimeText.resignFirstResponder()
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
    
    func displayQuestionMsg(userMsg: String){
        setMessageLanguageData(&cancell, key: "Cancel")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: "" ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            settingServicesList.remove(at: self.indexDelete)
            self.loading()
            self.deleteServices()
        }))
        let cancelAction = (UIAlertAction(title: cancell, style: .cancel, handler: { action in
            self.popAnimateOut(popView: self.addServiceViewPop)
        }))
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
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
    
    func displaySuccessMsg(userMsg: String){
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.getServices()
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
// ********************************** get services  **********************************
    
    func getServices(){
        let industryUrl = baseUrl + "industries/" + "\(industryID!)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: showIndustryModel?, error:Error?,status:Int?) in
            self.dismissLoding()
//            print(status)
            if status == 200 {
                let showIndustryDetails = model?.data
//                print(showIndustryDetails)

                settingServicesList = showIndustryDetails?.services ?? []
                print(settingServicesList)
                self.serviceTableView.reloadData()
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
// ********************************** delete services  **********************************
    
    func deleteServices(){
        let industryUrl = baseUrl + "services/" + "\(selectedSerId)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .delete, isHeaders: true) { (model: MessageModel?, error:Error?,status:Int?) in
            self.dismissLoding()
//            print(status)
            if status == 200 {
                setMessageLanguageData(&successfullyDeleted, key: "Successfuly deleted")
                self.displaySuccessMsg(userMsg: successfullyDeleted)
                self.serviceTableView.reloadData()
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
}

//var serviceListt : [ShowIndustryServices] = []



var serviceUpdated = String()
