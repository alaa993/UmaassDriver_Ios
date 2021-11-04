//
//  Statics.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation

import UIKit
import AlamofireImage
import Alamofire
import CoreData

let googleApiKey = "AIzaSyD3ASbAFjkkxVvYLo8B-FHjNB13UMVdna4"
var msgLoginSuccefull: String = "was successfully registered"

var successfullyDone = String()
var msgOk = String()
var msgAlert = String()
var yes           = String()
var no           = String()
var navigationEdit = String()
var navigationSave = String()

let msgAlertNewPassSend: String = "New password has been sent to you"
let msgConnectionToServerError: String = "Unable to communicate with the server"
let msgConnectionError: String = "No internet access"

let appID = "2278502678859504"
//let accountKitClientToken = "6bb31aaf3cb62c2adfcf9b53e99110a0"
//let accountKitAppSecret = "b65ca7b9e3568e5b15706d8293a92010"
let adMob = "ca-app-pub-6606021354718512~2824998371"
let unitId = "ca-app-pub-6606021354718512/5259590026"

// device token d49f9ece9f6dc94fb4a452ee46c364304eb1d30196332f97bb9dd83f94def9f8

// test "ca-app-pub-3940256099942544/2934735716"

let greenColor = UIColor(red: 45/255, green: 150/255, blue: 90/255, alpha: 1.0)
var offTextColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
var gray = UIColor(red: 200/255, green: 205/255, blue: 215/255, alpha: 1.0)

let stepOnLabelColor = UIColor(red: 105/255, green: 200/255, blue: 150/255, alpha: 1.0)
let stepOffLabelColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)

let emptyParam  : Parameters = [:]
var accesssToken = String()
var deviceTokenn = String()
var industryID  : Int?
let roleArray             = ["admin","coworker","assistant"]


var industryList  = [MyIndustryData]()

var accessToken = String()
var facebookToken = String()
var selectedCatId          : String?
var selectedCategoryName   : String?

var fromTo         : String?
var providerName   : String?
var industryName   : String?
var clientName     : String?
var clientPhone    : String?
var clientDesc     : String?
var clientage      : Int?
var clientGender   : Int?
var clientGendertxt: String?
var serviceId      : Int?
var staffId        : Int?
var appointmetID   : Int?
var acceptTheRules : String?

//var serviceList           = [showProviderServices]()
//var providerWorkingHors   = [showProviderWorkingHours]()
//var imageGallery          : [showProviderGallery]?
var providerLat           : String?
var providerLng           : String?

// --------------- variable -----------------
var adminName             : String?
var adminNumber           : String?
var adminEmail            : String?
var adminGender           : Int?
var adminDesc             : String?


var userName = String()
var userNumberRegist = String()
var userAge = String()
var userGender = String()
//skipped, commented, no-comment
// pending, confirmed, no-show, done

let confirmIcon = UIImage(named: "confirmm")
let doneIcon = UIImage(named: "done")
let pendingIcon = UIImage(named: "pending")
let noShowIcon = UIImage(named: "notShowing")

let markIcon = UIImage(named: "mark.png")
let unMarkIcon = UIImage(named: "unmark.png")
var cellTag    = Int()


var settingServicesList      = [ShowIndustryServices]()
var settingStaffList         = [ShowIndustryStaff]()
var settingWorkHours         = [ShowIndustryWorkingHours]()
var settingGallery           = [ShowIndustryGallery]()
var serviceCount             = Int()




func getImage(urlStr: String, img: UIImageView) {
    let imageUrl = urlStr
    let url = NSURL(string: imageUrl)
    if url != nil {
        img.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named: "user.png"), filter: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
    }
}


//func setLogo(navigation: UINavigationItem){
//    let button = UIButton.init(type: .custom)
//    let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//    let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//    heightConstraint.isActive = true
//    widthConstraint.isActive = true
//    button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
//    cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//    button.setImage(UIImage.init(named: ""), for: UIControl.State.normal)
//    let logoImg = UIBarButtonItem.init(customView: button)
//    navigation.rightBarButtonItem = logoImg
//
//}


func fetchUserToken(){
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    request.returnsObjectsAsFaults = false
    do{
        let results = try context.fetch(request)
        print(results.count)
        if (results.count) > 0 {
            for result in results as! [NSManagedObject] {
                if var token = result.value(forKey: "token") as? String {
                    token = accessToken
                    print("token: \(String(describing: accessToken))")
                }
            }
        }else{

        }
    }catch{
        //
    }
}


func saveToken(token: String) {
    let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
    newUser.setValue(token, forKey: "token")
    do{
        try context.save()
        print("saved accessToken: \(String(describing: token))")
    }catch{

    }
}

func saveCategoryId(categoryId: Int) {
    let newUser = NSEntityDescription.insertNewObject(forEntityName: "Industry", into: context)
    newUser.setValue(categoryId, forKey: "categoryId")
    do{
        try context.save()
        print("saved categoryId: \(String(describing: selectedCatId))")
    }catch{

    }
}

func saveLanguage(language: String, languageCode: String) {
    let newUser = NSEntityDescription.insertNewObject(forEntityName: "Setting", into: context)
    newUser.setValue(language, forKey: "appLanguage")
    newUser.setValue(languageCode, forKey: "languageCode")
    do{
        try context.save()
        print("saved language: \(String(describing: language))")
        print("saved languageCode: \(String(describing: languageCode))")
    }catch{
        
    }
}


func getFitView(targetview: UIView, view: UIView) {
    targetview.translatesAutoresizingMaskIntoConstraints = false
    targetview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    targetview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    targetview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
}




// change language function
// Kurdish ckb  ---  English en  ---  Arabic ar

var appLang = "English"
var resourceKey = "en"

func setMessage(key: String)->String {
    let path = Bundle.main.path(forResource: resourceKey, ofType: "lproj")
    let bundal = Bundle.init(path: path!)
   return (bundal?.localizedString(forKey: key, value: nil, table: nil))!
}


func setLabelLanguageData(label: UILabel, key: String) {
    let path = Bundle.main.path(forResource: resourceKey, ofType: "lproj")
    let bundal = Bundle.init(path: path!)
    // key ~> word in localizable.string
    label.text = bundal?.localizedString(forKey: key, value: nil, table: nil)
}

func setTextHintLanguageData(text: UITextField, key: String) {
    let path = Bundle.main.path(forResource: resourceKey, ofType: "lproj")
    let bundal = Bundle.init(path: path!)
    // key ~> word in localizable.string
    text.placeholder = bundal?.localizedString(forKey: key, value: nil, table: nil)
}

func setMessageLanguageData(_ message: inout String, key: String) {
    let path = Bundle.main.path(forResource: resourceKey, ofType: "lproj")
    let bundal = Bundle.init(path: path!)
    // key ~> word in localizable.string
    message = (bundal?.localizedString(forKey: key, value: nil, table: nil))!
}


func setButtonLanguageData(button: UIButton, key: String) {
    let path = Bundle.main.path(forResource: resourceKey, ofType: "lproj")
    let bundal = Bundle.init(path: path!)
    // key ~> word in localizable.string
    button.setTitle(bundal?.localizedString(forKey: key, value: nil, table: nil), for: .normal)
}






// ***********************************************************
var RequestPageTitle = String()
var appointmentPageTitle = String()
var appointmentDetailsPageTitle = String()
var reviewPageTitle = String()
var reviewDetailsPageTitle = String()
var setDataReviewPageTitle = String()
var settingPageTitle = String()
var workingHoursPageTitle = String()
var manageStaffPageTitle = String()
var manageServicePageTitle = String()
var providerLocationPageTitle = String()
var editProfilePageTitle = String()
var editIndustryPageTitle = String()
var galleryPageTitle = String()
var contactusPageTitle = String()
var aboutusPageTitle = String()
var commentsPageTitle = String()
var showImagePageTitle = String()

var industyrPageTitle = String()
var setMapPageTitle = String()
var setWorkingPageTitle = String()
var setServicePageTitle = String()
var setStaffPageTitle = String()



// token  1e26fdca9baba4d30370510e2283a5be6469959d6ab0ae77da4c4c568f3f1a37
