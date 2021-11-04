//
//  SuggestionVCViewController.swift
//  SnabulProvider
//
//  Created by kavos khajavi on 10/11/20.
//  Copyright © 2020 Hesam. All rights reserved.
//


import UIKit
import Alamofire

class SuggestionVCViewController: UIViewController {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var mobile: UITextField!
    @IBOutlet var countryTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    @IBOutlet var txSpecialty: UITextField!
    @IBOutlet var tfIntroducerCode: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    
    var modelMessage:MessageModel?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = setMessage(key:"Suggest Salon")
        nameTF.placeholder = setMessage(key:"Salon name")
        mobile.placeholder = setMessage(key:"phone number")
        countryTF.placeholder = setMessage(key:"country")
        cityTF.placeholder = setMessage(key:"city optional")
        txSpecialty.placeholder = setMessage(key: "Salon Specialty")
        tfIntroducerCode.placeholder = setMessage(key: "IntroducerCode")
        
        btnSubmit.setTitle(setMessage(key: "submit"), for: .normal)
        btnSubmit.layer.cornerRadius = 5
        btnSubmit.layer.masksToBounds = false



    }
    
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        save()
        
    }
    
    
    
    func save() {
        
 
        if nameTF.text?.count ?? 0 < 1 || mobile.text?.count ?? 0 < 1 && txSpecialty.text?.count ?? 0 < 1 {
            displayAlertMsg(userMsg: "Empty name or mobile or specialty")
            return
        }
        
        loading()
 
        let url = baseUrl+"suggest-provider"
        //fullname=&mobile=&country=\()&province=\()&specialty=\()"
        
        let parameters:Parameters = [
              "fullname" :nameTF.text ?? "",
              "mobile" :mobile.text ?? "",
              "country" :countryTF.text ?? "" ,
              "province" : cityTF.text ?? "",
              "specialty" : txSpecialty.text ?? ""]
        
        ServiceAPI.shared.fetchGenericData(urlString: url, parameters: parameters, methodInput: .post,isHeaders: true) { (model: MessageData?, error, status) in
            self.dismissLoding()
            
            if model?.message != nil {
                
                self.displaySuccessMsg(userMsg: model?.message ?? "")
                
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
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
}
