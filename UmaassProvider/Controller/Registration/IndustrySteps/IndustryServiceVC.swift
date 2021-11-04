//
//  IndustryServiceVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class IndustryServiceVC: UIViewController , UITableViewDelegate, UITableViewDataSource, manageServiceDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var oneLable         : UILabel!
    @IBOutlet weak var welcomeLabel     : UILabel!
    @IBOutlet weak var twoLabel         : UILabel!
    @IBOutlet weak var hoursLabel       : UILabel!
    @IBOutlet weak var threeLabel       : UILabel!
    @IBOutlet weak var staffLabel       : UILabel!
    @IBOutlet weak var fourLabel        : UILabel!
    @IBOutlet weak var mapLabel    : UILabel!
    @IBOutlet weak var fiveLabel        : UILabel!
    @IBOutlet weak var serviceLabel     : UILabel!
    
    
    @IBOutlet weak var addServiceTableView  : UITableView!
    @IBOutlet weak var serviceListView      : UIView!
    @IBOutlet var addServicePopView         : UIView!
    @IBOutlet weak var servicenameText      : UITextField!
    @IBOutlet weak var servicePriceText     : UITextField!
    @IBOutlet weak var serviceTimeText      : UITextField!
    
    @IBOutlet weak var serviceTimeType: UITextField!
    @IBOutlet weak var servicePriceType: UITextField!
    
    @IBOutlet weak var nextBtnOutlet        : UIButton!
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var addServiceLab: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var setServiceLab: UILabel!
    @IBOutlet weak var serviceMessageLab: UILabel!
    
    
    var blackView       = UIView()
    
    var parameterToSend       : [String:Any] = [:]
    var formData              : [[String:Any]] = [[:]]
    var parameterJson         = String()
    var serviceId             = String()
    
    var indexDelete           = Int()
    var editIndex             = Int()
    
    var isEdited              : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: welcomeLabel, key: "Welcome")
        setLabelLanguageData(label: mapLabel, key: "hours")
        setLabelLanguageData(label: staffLabel, key: "staff")
        setLabelLanguageData(label: serviceLabel, key: "Service")
        
        setButtonLanguageData(button: addBtn, key: "add")
        
        setLabelLanguageData(label: addServiceLab, key: "Add  services")
        setTextHintLanguageData(text: servicenameText, key: "Name")
        setTextHintLanguageData(text: servicePriceText, key: "price")
        setTextHintLanguageData(text: serviceTimeText, key: "time duration")
        
        
        setLabelLanguageData(label: setServiceLab, key: "add the services you offer")
        setLabelLanguageData(label: serviceMessageLab, key: "Don't worry - you'll be able to edit these later")
        setButtonLanguageData(button: nextBtnOutlet, key: "Next")
        
        setMessageLanguageData(&setServicePageTitle, key: "Service")
        self.navigationItem.title = setServicePageTitle
        
        ManageServiceModel.append(ManageServiceDataModel(industry_id: industryID ?? 1, title: "service", duration: 30 , price: 40, notes_for_the_customer: "notes",TypeTime: "min",TypePrice: "$"))
        
        cornerViews(view: addServicePopView, cornerValue: 8.0, maskToBounds: true)
        cornerViews(view: serviceListView, cornerValue: 6.0, maskToBounds: true)
        cornerButton(button: nextBtnOutlet, cornerValue: 6.0, maskToBounds: true)
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: view.frame.width / 2, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
        
        let addServiceBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addService))
        navigationItem.rightBarButtonItem = addServiceBarButton
        
        
        oneLable.backgroundColor = stepOnLabelColor
        twoLabel.backgroundColor = stepOnLabelColor
        threeLabel.backgroundColor = stepOnLabelColor
        fourLabel.backgroundColor = stepOnLabelColor
        fiveLabel.backgroundColor = stepOffLabelColor
        
        
        cornerLabel(label: oneLable, cornerValue: Float(oneLable.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: twoLabel, cornerValue: Float(twoLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: threeLabel, cornerValue: Float(threeLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fourLabel, cornerValue: Float(fourLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fiveLabel, cornerValue: Float(fiveLabel.frame.height / 2) , maskToBounds: true)
    }
    
    @objc func addService () {
        servicenameText.text = ""
        servicePriceText.text = ""
        serviceTimeText.text = ""
        isEdited = false
        popAnimationIn(popView: addServicePopView)
    }
    
    @IBAction func addServiceTapped(_ sender: Any) {
        
        setMessageLanguageData(&enterServiceName, key: "Enter service name")
        setMessageLanguageData(&enterServicePrice, key: "Enter service price")
        setMessageLanguageData(&enterServiceTime, key: "Enter service time duration")
        
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
            
            let servName = self.servicenameText.text ?? "service name"
            
            var NumberStr: String = self.serviceTimeText.text ?? "10"
            let Formatter = NumberFormatter()
            Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            if let final = Formatter.number(from: NumberStr) {
                print(final)
                NumberStr = "\(final)"
                print(NumberStr)
            }
            
            var priceStr: String = self.servicePriceText.text ?? "10"
            Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            if let final = Formatter.number(from: priceStr) {
                print(final)
                priceStr = "\(final)"
                print(priceStr)
            }
            let typeTime = self.serviceTimeType.text ?? "min"
            let typePrice = self.servicePriceType.text ?? "$"
            if isEdited == true {
                isEdited = false
                ManageServiceModel.remove(at: editIndex)
                popAnimateOut(popView: addServicePopView)
                
                ManageServiceModel.insert(ManageServiceDataModel(industry_id: industryID ?? 1, title: servName, duration: Int(NumberStr), price: Int(priceStr), notes_for_the_customer: "note",TypeTime: typeTime,TypePrice: typePrice), at: editIndex)
                
                self.addServiceTableView.reloadData()
            }else{
                popAnimateOut(popView: addServicePopView)
                ManageServiceModel.append(ManageServiceDataModel(industry_id: industryID ?? 1, title: servName, duration: Int(NumberStr), price: Int(priceStr), notes_for_the_customer: "notes",TypeTime: typeTime,TypePrice: typePrice))
                //                print(ManageServiceModel)
                self.addServiceTableView.reloadData()
            }
        }
    }
    
//*****************************  Service list ***********************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManageServiceModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ServCell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableCell", for: indexPath) as! ServiceTableViewCell
        
        if indexPath.row == 0 {
            ServCell.servDeleteOutlet.isHidden = true
        }else{
            ServCell.servDeleteOutlet.isHidden = false
        }
        
        serviceCellDelegate = self
        ServCell.serviceTimeLabel.text = "\(ManageServiceModel[indexPath.row].duration ?? 20)" + "\(ManageServiceModel[indexPath.row].TypeTime ?? " min")"
        ServCell.serviceNameLable.text = ManageServiceModel[indexPath.row].title
        ServCell.servicePriceLabel.text = "\(ManageServiceModel[indexPath.row].price ?? 20)" + "\(ManageServiceModel[indexPath.row].TypePrice ?? " $")"
        
        return ServCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func deleteService(cell: UITableViewCell) {
        let index = addServiceTableView.indexPath(for: cell)!
        indexDelete = index.row
        print(indexDelete)
        setMessageLanguageData(&deleteServiceMessage, key: "do you want to delete this service")
        displayQuestionMsg(userMsg: deleteServiceMessage)
    }
    
    func editService(cell: UITableViewCell) {
        let index = self.addServiceTableView.indexPath(for: cell)
        print(index!)
        isEdited = true
        editIndex = index?.row ?? 0
        servicenameText.text = ManageServiceModel[(index?.row)!].title ?? ""
        servicePriceText.text = "\(ManageServiceModel[(index?.row)!].price ?? 10)"
        serviceTimeText.text = "\(ManageServiceModel[(index?.row)!].duration ?? 10)"
        popAnimationIn(popView: addServicePopView)
    }
    

    
    @IBAction func dismissPop(_ sender: Any) {
        isEdited = false
        popAnimateOut(popView: addServicePopView)
    }
    
    @IBAction func finishSetUpTapped(_ sender: Any) {
        loading()
        //        startActivity(view: self.view)
        //        print(ManageServiceModel)
        let ManageServiceDataModelUrl = baseUrl + "services"
        print(ManageServiceDataModelUrl)
        do {
            print(ManageServiceModel)
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(ManageServiceModel)
            jsonEncoder.outputFormatting = .prettyPrinted
            
            let url = URL(string: ManageServiceDataModelUrl)
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
                
                if status == 200 {
                    if (response.result.value) != nil {
                        let swiftyJsonVar = JSON(response.result.value!)
                        print("create service swiftyJsonVar ---------- ",swiftyJsonVar)
                        
                        setMessageLanguageData(&serviceCreateMessage, key: "your services create successfully")
                        self.displaySuccessMsg(userMsg: serviceCreateMessage)
                    }
                }
                if status == 422 {
                    setMessageLanguageData(&invalidData, key: "Invalid data")
                    self.displayAlertMsg(userMsg: invalidData)
                }
            }
        }catch {
            
        }
    }
    
//***************************** Hide KeyBoard ***********************************
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addServicePopView.endEditing(true)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == servicenameText {
            servicenameText.resignFirstResponder()
        }
        if textField == serviceTimeText {
            serviceTimeText.resignFirstResponder()
        }
        if textField == servicePriceText {
            servicePriceText.resignFirstResponder()
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
        
        let myAlert = UIAlertController(title:  successfullyDone,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
          //  self.performSegue(withIdentifier: "toStaff", sender: self)
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = myTabBar
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displayQuestionMsg(userMsg: String){
        setMessageLanguageData(&cancell, key: "Cancel")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: "" ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            ManageServiceModel.remove(at: self.indexDelete)
            self.addServiceTableView.reloadData()
        }))
        let cancelAction = (UIAlertAction(title: cancell, style: .cancel, handler: { action in
            
        }))
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated:true, completion:nil);
    }
}


var ManageServiceModel   : [ManageServiceDataModel] = []



var enterServiceName = String()
var enterServicePrice = String()
var enterServiceTime = String()

var deleteServiceMessage  = String()
var serviceCreateMessage  = String()
