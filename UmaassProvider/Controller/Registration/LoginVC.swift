//
//  LoginVC.swift
//  QdorUser
//
//  Created by Hesam on 10/8/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseUI
import CountryList

import CoreData

class LoginVC: UIViewController {
    
    @IBOutlet weak var enBTNOut: UIButton!
    @IBOutlet weak var KrBTNOut: UIButton!
    @IBOutlet weak var ArBTNOut: UIButton!
    @IBOutlet weak var TurkBTNOut: UIButton!
    @IBOutlet weak var topView          : UIView!
    @IBOutlet weak var numberView       : UIView!
    @IBOutlet weak var image            : UIImageView!
    @IBOutlet weak var numberText       : UITextField!
    @IBOutlet weak var loginBtn         : UIButton!
    @IBOutlet var btnSelectCode: UIButton!
   
    @IBOutlet weak var SelectLang: UIView!
    
    //view verifi
    
    @IBOutlet weak var SelectbtnOut: UIButton!
    
    @IBOutlet var lbPhoneNumber: UILabel!
    @IBOutlet var mainViewVerify: UIView!
    @IBOutlet var btnVeify: UIButton!
    @IBOutlet var otpInputView: OTPInputView!
    
    var countryList = CountryList()
    var codeCountry = ""
    var isLoginVC : Bool = false
    
    var notRegisterUser = String()
    var InvalidData = String()
    var notRegister = String()
    var blackView              = UIView()
    
    fileprivate var authStateDidChangeHandle: AuthStateDidChangeListenerHandle?
    fileprivate(set) var auth: Auth?
    fileprivate(set) var authUI: FUIAuth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginBtn.layer.cornerRadius = 8
        loginBtn.layer.masksToBounds = false
        loginBtn.layer.shadowColor = UIColor.black.cgColor
        loginBtn.layer.shadowRadius = 2.0
        loginBtn.layer.shadowOpacity = 0.8
        loginBtn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        loginBtn.layer.shadowColor = UIColor(red: 120/255 , green: 120/255, blue: 120/255, alpha: 1.0).cgColor
        
        btnSelectCode.layer.borderColor = UIColor.gray.cgColor
        btnSelectCode.layer.borderWidth = 1
        btnSelectCode.layer.cornerRadius = 5
        btnSelectCode.setTitle("+964", for: .normal)
        numberText.keyboardType = .asciiCapableNumberPad
        
        btnVeify.layer.cornerRadius = 8
        btnVeify.layer.masksToBounds = false
        btnVeify.layer.shadowColor = UIColor.black.cgColor
        btnVeify.layer.shadowRadius = 2.0
        btnVeify.layer.shadowOpacity = 0.8
        btnVeify.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btnVeify.layer.shadowColor = UIColor(red: 120/255 , green: 120/255, blue: 120/255, alpha: 1.0).cgColor
        
        countryList.delegate = self
        otpInputView.delegateOTP = self
        
        codeCountry = "+964"
        
        
        self.topView.frame = CGRect(x: 0, y: 40, width: view.frame.width-30 , height: view.frame.height-40)
        
        self.mainViewVerify.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width-30, height: view.frame.height-40)
        
       
        
        
    }
    
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

    @IBAction func English(_ sender: Any) {
        SelectbtnOut.backgroundColor = greenColor
        SelectbtnOut.isEnabled = true
        enBTNOut.setImage(UIImage(named: "selectOn"), for: .normal)
        KrBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        ArBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        TurkBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        
        appLang = "English"
        resourceKey = "en"
    }
    
    @IBAction func Arabic_btn(_ sender: Any) {
        SelectbtnOut.backgroundColor = greenColor
        SelectbtnOut.isEnabled = true
        enBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        KrBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        ArBTNOut.setImage(UIImage(named: "selectOn"), for: .normal)
        TurkBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        
        appLang = "Arabic"
        resourceKey = "ar"
    }
    
    @IBAction func Kurd_btn(_ sender: Any) {
        SelectbtnOut.backgroundColor = greenColor
        SelectbtnOut.isEnabled = true
        enBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        KrBTNOut.setImage(UIImage(named: "selectOn"), for: .normal)
        ArBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        TurkBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        
        appLang = "Kurdish"
        resourceKey = "ckb"
    }
    @IBAction func Turk_btn(_ sender: Any) {
        enBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        KrBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        ArBTNOut.setImage(UIImage(named: "selectOff"), for: .normal)
        TurkBTNOut.setImage(UIImage(named: "selectOn"), for: .normal)
        
        appLang = "Turkish"
        resourceKey = "tr"
    }
    
    @IBAction func SelectLangBtn(_ sender: Any) {
        let request: NSFetchRequest<Setting> = Setting.fetchRequest()
        do {
            let results = try context.fetch(request)
            for result in results as [NSManagedObject] {
                context.delete(result)
                print("User Data: \(results) is deleted")
            }
            do {
                try context.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        } catch {
            print("Error with request: \(error)")
        }
        
        
        popAnimateOut(popView: SelectLang)
   
        saveLanguage(language: appLang, languageCode: resourceKey)
        self.saveChangelanguge()
    }
    func saveChangelanguge() {
           
           loading()
           var finalUrl           = String()
           var languge = ""
           var deviceId = ""
           let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
           deviceId = "provider-" + UUIDValue
           let baseurll = baseUrl + "user/language?device_id=\(deviceId)"
           
           switch resourceKey {
           case "en":
               languge = "&language=EN"
           case "ar":
               languge = "&language=AR"
           case "ckb":
               languge = "&language=KU"
            case "tr":
                languge = "&language=TR"
           default:
               languge = "&language=EN"
           }
           
           let finalUr = baseurll + languge
           
           if finalUr.contains(" ")  {
               finalUrl = finalUr.replacingOccurrences(of: " ", with: "%20")
           }else{
               finalUrl = finalUr
           }
           
           let headers:HTTPHeaders = [
               "Authorization": "Bearer \(accesssToken)",
               "X-Requested-With": "application/json",
              // "Content-type" : "application/json",
               "Accept" : "application/json"
           ]
           
           Alamofire.request(finalUrl, method: .patch, headers: headers).responseJSON { response in
               self.dismissLoding()
              
            let reloadPage = self.storyboard?.instantiateViewController(withIdentifier: "SplashScreen")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = reloadPage
            appDelegate.ChangeLayout()
               
           }
       }
    
    


    @IBAction func ChangeLang(_ sender: Any) {
        popAnimationIn(popView: SelectLang)
    }
    @IBAction func exitLang(_ sender: Any) {
    }
    func login(token: String,phonNumber:String){
        let newString = phonNumber.replacingOccurrences(of: "+", with: "%2B")
        let loginUrl = baseUrl+"login?access_token=\(token)&phone=\(newString)"
        print(loginUrl)
        Alamofire.request(loginUrl, method: .post).responseJSON { response in
            self.dismissLoding()
            if let value: AnyObject = response.result.value as AnyObject? {
                let post = JSON(value)
                let status = response.response?.statusCode
                if status == 201 || status == 200 {
                    let resData = post["data"].dictionaryObject
                    let tokenStr = resData?["token"] as? String
                    print(tokenStr ?? "")
                    accesssToken = tokenStr ?? ""
                    saveToken(token: tokenStr ?? "")
                    self.getAllIndustry()
                }
                if status == 412 {
                    setMessageLanguageData(&self.notRegisterUser, key: "The user has not register yet")
                    self.displayNotExsistMsg(userMsg: self.notRegisterUser,ph: phonNumber)
                }
                if status == 422 {
                    setMessageLanguageData(&self.InvalidData, key: "Invalid data")
                    self.displayAlertMsg(userMsg: self.InvalidData)
                }
            }
        }
    }
    
    
    //  *************************************** get industries *****************************************
    func getAllIndustry(){
        let industryUrl = baseUrl + "industries?mine=true"
        print(industryUrl)
        print(accesssToken)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: MyIndustryModel?, error:Error?,status:Int?) in
            self.getProfile()
            if status == 200 {
                industryList = model?.data ?? []
                print(industryList)
                if industryList.count > 0 {
                   
                    let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "switchIndustry") as! SwitchIndustryVC
                  
                    self.present(destVC, animated: false, completion: nil)
                }else{
                    self.performSegue(withIdentifier: "toIndustry", sender: self)
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    
    // ******************************** Alert Message ********************************
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displayNotExsistMsg(userMsg: String,ph: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        setMessageLanguageData(&self.notRegister, key: "Not registered")
        
        let myAlert = UIAlertController(title: self.notRegister ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            
            let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registration") as! RegistrationVC
            destVC.phoneNumber = ph
            self.present(destVC, animated: false, completion: nil)
            
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    
    @IBAction func btnActionVerify(_ sender: Any) {
        
        otpInputView.otpFetch()
        
    }
    @IBAction func btnActionRusem(_ sender: Any) {
        
        self.topView.frame = CGRect(x: 0, y: 40, width: view.frame.width-30 , height: view.frame.height-40)
        
        self.mainViewVerify.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width-30, height: view.frame.height-40)
    }
    
    
    @IBAction func btnActionSelectCode(_ sender: Any) {
        
        let navController = UINavigationController(rootViewController: countryList)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
      /*  setMessageLanguageData(&enterYourNumber, key: "Please Enter Your Number")
        numberText.resignFirstResponder()
        Analytics.logEvent("loginWithFacebook", parameters: nil)
        
        if (numberText.text == "") || (numberText.text!.isEmpty) {
            displayAlertMsg(userMsg: enterYourNumber)
        }else{
            let number = numberText.text ?? ""
            if number == "9647731357575" {
                loginWithNumber(number: "9647731357575")
                
            }else{
                sendPhoneNumber()
            }
        }*/
        auth = Auth.auth()
                    authUI = FUIAuth.defaultAuthUI()
                    authUI?.delegate = self
                    let phoneProvider = FUIPhoneAuth.init(authUI: authUI!)
                    authUI?.providers = [phoneProvider]
                DispatchQueue.main.async {
                    phoneProvider.signIn(withPresenting: self, phoneNumber: nil);
                }
    }
    
    
    func loginWithNumber(number: String){
        let loginUrl = baseUrl + "login?access_token=abcd&phone=%2B" + number
        print(loginUrl)
        loading()
        Alamofire.request(loginUrl, method: .post).responseJSON { response in
            self.dismissLoding()
            if let value: AnyObject = response.result.value as AnyObject? {
                let post = JSON(value)
                print(post)
                let status = response.response?.statusCode
                print(status)
                self.dismissLoding()
                if status == 201 || status == 200 {
                    let resData = post["data"].dictionaryObject
                    let tokenStr = resData?["token"] as? String
                    print(tokenStr ?? "")
                    accesssToken = tokenStr ?? ""
                    saveToken(token: tokenStr ?? "")
                    self.getAllIndustry()
                    
                }
                if status == 412 {
                    setMessageLanguageData(&self.notRegisterUser, key: "The user has not register yet")
                    self.displayNotExsistMsg(userMsg: self.notRegisterUser,ph: number)
                }
                if status == 422 {
                    setMessageLanguageData(&self.InvalidData, key: "Invalid data")
                    self.displayAlertMsg(userMsg: self.InvalidData)
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    
    func sendPhoneNumber()  {
        
        self.loading()
        let phonNumber = numberText.text
        if phonNumber?.count ?? 0 < 1 {
            return
        }
        
        let phonnumber = "\(codeCountry)\(phonNumber ?? "")"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phonnumber, uiDelegate: nil) { (verificationID, error) in
            self.dismissLoding()
            if let error = error {
                self.displayAlertMsg(userMsg: error.localizedDescription)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            self.lbPhoneNumber.text = phonnumber
            self.topView.frame = CGRect(x: 0, y: CGFloat(self.view.frame.height), width: self.view.frame.width-30, height: self.view.frame.height-40)
            
            self.mainViewVerify.frame = CGRect(x: 0, y: 40, width: self.view.frame.width-30 , height: self.view.frame.height-40)
            
        }
        
        
    }
    
    
    func verifiy(code:String)  {
        
        self.loading()
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider()
            .credential(withVerificationID: verificationID,verificationCode:code )
        Auth.auth().signIn(with: credential) { (authResult, error) in
            self.dismissLoding()
            if let error = error {
                self.displayAlertMsg(userMsg:error.localizedDescription)
                return
            }
            UserDefaults.standard.set(nil, forKey: "authVerificationID")
            
            facebookToken = authResult?.additionalUserInfo?.providerID ?? "defalt"
            self.login(token: authResult?.additionalUserInfo?.providerID ?? "defalt", phonNumber: authResult?.user.phoneNumber ?? "")
            
        }
        
    }
    
    
       func getProfile(){
            let profileUrl = baseUrl + "profile"
            print(profileUrl)
            ServiceAPI.shared.fetchGenericData(urlString: profileUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: profileModell?, error:Error?,status:Int?) in

                if status == 200 {
                    let profile = model?.data
                    let gender = profile?.gender
                    self.saveProfile(gender:gender ?? 1)
                    

            }
        }
    }
    
    var deviceId           : String?
    var finalUrl           = String()
    // ------------ device info -------------
        func saveProfile(gender:Int) {
         var languge = ""
        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
          deviceId = "provider-" + UUIDValue
        
        let baseurll = baseUrl + "profile?&name="
        let firstUrl = "&email="
        let devicetype = "&device_type=ios&device_token=" + deviceTokenn
        let idDevice = "&device_id=" + (deviceId ?? "")
        let gender2 = "&gender=" + "\(gender )"
        
            switch resourceKey {
            case "en":
                languge = "&language=EN"
            case "ar":
                languge = "&language=AR"
            case "ckb":
                languge = "&language=KU"
            case "tr":
                languge = "&language=TR"
            default:
                languge = "&language=EN"
            }
        
        let finalUr = baseurll + firstUrl + devicetype + idDevice + languge + gender2
        
        if finalUr.contains(" ")  {
            finalUrl = finalUr.replacingOccurrences(of: " ", with: "%20")
        }else{
            finalUrl = finalUr
        }
        
        print(finalUrl)
        print(accesssToken)
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(accesssToken)",
            "X-Requested-With": "application/json",
            "Accept" : "application/json"
        ]
        
        Alamofire.request(finalUrl, method: .put, headers: headers).responseJSON { response in
           
            print("saveProfile",response)
        }
    }
    
}


extension LoginVC : CountryListDelegate {
    
    func selectedCountry(country: Country) {
        codeCountry = "+\(country.phoneExtension)"
        btnSelectCode.setTitle("\(codeCountry)", for: .normal)
    }
}

extension LoginVC: OTPViewDelegate {
    
    func didFinishedEnterOTP(otpNumber: String) {
        verifiy(code: otpNumber)
    }
    
    func otpNotValid() {
        
        displayAlertMsg(userMsg: "Code Error")
        // showPopupAlert(title:"OTP Error", message:"")
    }
    
}
extension LoginVC:FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        self.login(token: authDataResult?.additionalUserInfo?.providerID ?? "defalt", phonNumber: authDataResult?.user.phoneNumber ?? "")
      /*  loginByMobile(mobileNumber: String((authDataResult?.user.phoneNumber)!),
                      password: String((authDataResult?.user.uid)!),
                      token: String((authDataResult?.user.refreshToken)!))
    }*/

}
}
