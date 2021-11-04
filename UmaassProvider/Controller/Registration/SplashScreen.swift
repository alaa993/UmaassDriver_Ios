//
//  SplashScreen.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class SplashScreen: UIViewController {

    @IBOutlet weak var appNameLabel     : UILabel!
    @IBOutlet weak var progressView     : UIProgressView!
   
    @IBOutlet weak var onlineBookingLab : UILabel!
    
    
    var token              : String?
    var deviceId           : String?
    var updateProfileUrl   = String()
    var finalUrl           = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: appNameLabel, key: "splashAppName")
        setLabelLanguageData(label: onlineBookingLab, key: "Online booking")
//        setLabelLanguageData(label: versionLabel, key: "Version")
//
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer: Timer) in
            self.progressView.setProgress(self.progressView.progress + 0.1, animated: true)
            if self.progressView.progress >= 1.0 {
                timer.invalidate()
            }
        }
        timer.fire()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if currentReachabilityStatus == .notReachable{
            DispatchQueue.main.async {
                self.displayAlertMsg(userMsg: msgConnectionError)
            }
        }else{
            progressView.semanticContentAttribute = .forceLeftToRight
            perform(#selector(SplashScreen.fetchUserToken), with: nil, afterDelay: 3)
            let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
            print("UUID: \(UUIDValue)")
            deviceId = "provider-" + UUIDValue
//            getAppVersion()
          
        }
    }
    
   
    
    @objc func fetchUserToken(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            print(results.count)
            if (results.count) > 0 {
                for result in results as! [NSManagedObject] {
                    if let token = result.value(forKey: "token") as? String {
                        accesssToken = token
                        print("token: \(String(describing: accesssToken))")
                        print("Welcome To Umaass Provide")
                        let index : Int? = 0
                        let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = myTabBar
                        myTabBar.selectedIndex = index!
                    }
                }
            }else{
                print("this user loged out, please register")
                performSegue(withIdentifier: "toLogin", sender: self)
            }
        }catch{
            //
        }
    }
    
//    func getAppVersion(){
//        let versionUrl = baseUrl + "version/ios"
//        ServiceAPI.shared.fetchGenericData(urlString: versionUrl, parameters: emptyParam, methodInput: .get) { (model: aboutUsModel?, error, status) in
//
//            if status == 200 {
//                self.versionLabel.text = "App Version  " + "\(model?.data?.version ?? 1)"
//
//            }else{
//
//            }
//        }
//    }
    
    // ------------ device info -------------
//    func saveProfile() {
//        let baseurll = baseUrl + "profile?&name="
//        let firstUrl = "&email="
//        let devicetype = "&device_type=ios&device_token=" + deviceTokenn
//        let idDevice = "&device_id=" + (deviceId ?? "")
//
//        let finalUr = baseurll + firstUrl + devicetype + idDevice
//
//        if finalUr.contains(" ")  {
//            finalUrl = finalUr.replacingOccurrences(of: " ", with: "%20")
//        }else{
//            finalUrl = finalUr
//        }
//
//        print(finalUrl)
//        print(accesssToken)
//        let headers:HTTPHeaders = [
//            "Authorization": "Bearer \(accesssToken)",
//            "X-Requested-With": "application/json",
//            "Content-type" : "application/json",
//            "Accept" : "application/json"
//        ]
//
//        Alamofire.request(finalUrl, method: .put, headers: headers).responseJSON { response in
//            self.dismissLoding()
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let post = JSON(value)
//                print(post)
//                let status = response.response?.statusCode
//                print(status)
//                let data = post["data"].dictionary
//                let message = data?["message"]?.stringValue
//                print(message)
//                if status == 200 {
//
//                }else {
//
//                }
//            }
//        }
  // }
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
}
