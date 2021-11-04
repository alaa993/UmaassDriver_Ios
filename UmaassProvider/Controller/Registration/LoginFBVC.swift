////
////  LoginFBVC.swift
////  UmaassProvider
////
////  Created by Hesam on 7/2/1398 AP.
////  Copyright © 1398 Hesam. All rights reserved.
////
//
//import UIKit
//import AccountKit
//import Alamofire
//import SwiftyJSON
//import Firebase
//
//
//class LoginFBVC: UIViewController, AKFViewControllerDelegate, AdvancedUIManager {
//    
//    @IBOutlet weak var topView          : UIView!
//    @IBOutlet weak var numberView       : UIView!
//    @IBOutlet weak var numberText       : UITextField!
//    @IBOutlet weak var loginBtn         : UIButton!
//    
//    
//    var notRegisterUser = String()
//    var InvalidData = String()
//    var notRegister = String()
//    
//    var loginModelToSend : [loginParam] = []
//    var isLoginVC : Bool = false
//
//    var accountKit : AccountKitManager = AccountKitManager(responseType: .accessToken)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        numberView.layer.cornerRadius = numberView.frame.height / 2
//        numberView.layer.masksToBounds = false
//        numberView.layer.shadowOpacity = 0.5
//        numberView.layer.shadowRadius = 4.0
//        numberView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        numberView.layer.shadowColor = UIColor(red: 120/255 , green: 120/255, blue: 120/255, alpha: 1.0).cgColor
//        
//        loginBtn.layer.cornerRadius = loginBtn.frame.height / 2
//        loginBtn.layer.masksToBounds = false
//        loginBtn.layer.shadowColor = UIColor.black.cgColor
//        loginBtn.layer.shadowRadius = 2.0
//        loginBtn.layer.shadowOpacity = 0.8
//        loginBtn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        loginBtn.layer.shadowColor = UIColor(red: 120/255 , green: 120/255, blue: 120/255, alpha: 1.0).cgColor
//        
//        numberText.keyboardType = .asciiCapableNumberPad
//    }
//    
//    
//    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AKFAccessToken, state: String) {
//        loading()
//        print("accessToken",accessToken.tokenString)
//        facebookToken = accessToken.tokenString
//        print(facebookToken)
//        login(token: facebookToken)
//    }
//    
////    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AccessToken, state: String) {
////        loading()
////        print("accessToken",accessToken.tokenString)
////        facebookToken = accessToken.tokenString
////        print(facebookToken)
////        login(token: facebookToken)
////    }
//    
//    func login(token: String){
//        let loginUrl = baseUrl + "login?access_token=" + token
//        print(loginUrl)
//        Alamofire.request(loginUrl, method: .post).responseJSON { response in
//            self.dismissLoding()
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let post = JSON(value)
//                let status = response.response?.statusCode
//                if status == 201 || status == 200 {
//                    let resData = post["data"].dictionaryObject
//                    let tokenStr = resData?["token"] as? String
//                    print(tokenStr ?? "")
//                    accesssToken = tokenStr ?? ""
//                    saveToken(token: tokenStr ?? "")
//                    self.getAllIndustry()
//                }
//                if status == 412 {
//                    setMessageLanguageData(&self.notRegisterUser, key: "The user has not register yet")
//                    self.displayNotExsistMsg(userMsg: self.notRegisterUser)
//                }
//                if status == 422 {
//                    setMessageLanguageData(&self.InvalidData, key: "Invalid data")
//                    self.displayAlertMsg(userMsg: self.InvalidData)
//                }
//            }
//        }
//    }
//    
//    
////  *************************************** get industries *****************************************
//    func getAllIndustry(){
//        let industryUrl = baseUrl + "industries?mine=true"
//        print(industryUrl)
//        print(accesssToken)
//        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: MyIndustryModel?, error:Error?,status:Int?) in
//            print(status)
//            if status == 200 {
//                industryList = model?.data ?? []
//                print(industryList)
//                if industryList.count > 0 {
//                    let destVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "switchIndustry") as! SwitchIndustryVC
//                    self.present(destVC, animated: false, completion: nil)
//                }else{
//                    self.performSegue(withIdentifier: "toIndustry", sender: self)
//                }
//            }else{
//                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
//                self.displayAlertMsg(userMsg: someThingWentWrong)
//            }
//        }
//    }
//
//    
//    // ******************************** Alert Message ********************************
//    func displayAlertMsg(userMsg: String){
//        setMessageLanguageData(&msgAlert, key: "Warrning")
//        setMessageLanguageData(&msgOk, key: "Ok")
//        
//        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
//        myAlert.addAction(okAction)
//        self.present(myAlert, animated:true, completion:nil);
//    }
//    
//    func displayNotExsistMsg(userMsg: String){
//        setMessageLanguageData(&msgAlert, key: "Warrning")
//        setMessageLanguageData(&msgOk, key: "Ok")
//        setMessageLanguageData(&self.notRegister, key: "Not registered")
//        
//        let myAlert = UIAlertController(title: self.notRegister ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
//        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
//            
//            let destVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registration") as! RegistrationVC
//            self.present(destVC, animated: false, completion: nil)
//            
//        }))
//        myAlert.addAction(okAction)
//        self.present(myAlert, animated:true, completion:nil);
//    }
//    
//    @IBAction func loginTapped(_ sender: Any) {
//        setMessageLanguageData(&enterYourNumber, key: "Please Enter Your Number")
//        numberText.resignFirstResponder()
//        Analytics.logEvent("loginWithFacebook", parameters: nil)
//        
//        if (numberText.text == "") || (numberText.text!.isEmpty) {
//            displayAlertMsg(userMsg: enterYourNumber)
//        }else{
//            let number = numberText.text ?? ""
//            if number == "9647731357575" {
//                loginWithNumber(number: "9647731357575")
//                
//            }else{
//                let inputState = UUID().uuidString
//                let vc = (accountKit.viewControllerForPhoneLogin(with: .init(countryCode: "+946", phoneNumber: number
//                    ), state: inputState))
//                vc.isSendToFacebookEnabled = true
//                vc.delegate = self
//                self.present(vc as UIViewController, animated: true, completion: nil)
//            }
//        }
//    }
//    
//    func loginWithNumber(number: String){
//        let loginUrl = baseUrl + "login?access_token=abcd&phone=%2B" + number
//        print(loginUrl)
//        loading()
//        Alamofire.request(loginUrl, method: .post).responseJSON { response in
//            self.dismissLoding()
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let post = JSON(value)
//                print(post)
//                let status = response.response?.statusCode
//                print(status)
//                self.dismissLoding()
//                if status == 201 || status == 200 {
//                    let resData = post["data"].dictionaryObject
//                    let tokenStr = resData?["token"] as? String
//                    print(tokenStr ?? "")
//                    accesssToken = tokenStr ?? ""
//                    saveToken(token: tokenStr ?? "")
//                    self.getAllIndustry()
//                }
//                if status == 412 {
//                    setMessageLanguageData(&self.notRegisterUser, key: "The user has not register yet")
//                    self.displayNotExsistMsg(userMsg: self.notRegisterUser)
//                }
//                if status == 422 {
//                    setMessageLanguageData(&self.InvalidData, key: "Invalid data")
//                    self.displayAlertMsg(userMsg: self.InvalidData)
//                }
//            }else{
//                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
//                self.displayAlertMsg(userMsg: someThingWentWrong)
//            }
//        }
//    }
//    
//    
//}
//
//
//
//
//
//
//
