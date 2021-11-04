//
//  SettingVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import CoreData


class SettingVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var addBtn            : UIButton!
    @IBOutlet weak var profileImage      : UIImageView!
    @IBOutlet weak var adminNameLabel    : UILabel!
    @IBOutlet weak var adminEmailLabel   : UILabel!
    @IBOutlet weak var adminPhoneLabel   : UILabel!
    @IBOutlet weak var descriptionLabel  : UILabel!
    
    @IBOutlet weak var languageLbl              : UILabel!
    
    @IBOutlet weak var workingBtn: UIButton!
    @IBOutlet weak var staffBtn: UIButton!
    @IBOutlet weak var serviceBtn: UIButton!
    @IBOutlet weak var mapbtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var editIndstryBtn: UIButton!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var addressLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var emailLab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    
    @IBOutlet var turkishLabel: UILabel!
    @IBOutlet var turkishIconButton: UIButton!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var arabicIconBtn: UIButton!
    @IBOutlet var selectLangView: UIView!
    @IBOutlet weak var selectLangLab: UILabel!
    @IBOutlet weak var englishLab: UILabel!
    @IBOutlet weak var kurdishLab: UILabel!
    @IBOutlet weak var arabicLab: UILabel!
    @IBOutlet weak var englishIconBtn: UIButton!
    @IBOutlet weak var kurdishIconBtn: UIButton!
    @IBOutlet weak var selectLangOutletBtn: UIButton!
    
    
    @IBOutlet var btnSuggestion: UIButton!
    @IBOutlet var btnGroup: UIButton!
    
    
    @IBOutlet var label_Interoduce: UILabel!
    @IBOutlet var label_Value_Interoduce: UILabel!
    
    var blackView              = UIView()
    var imagesArray       = [UIImage]()
    var pickedImage       : UIImage?
    var addressString     : String?
    
    
    var adminName : String?
    var adminEmail : String?
    var adminGender : String?
    //    var adminBirtday : String?
    var adminPhone : String?
    var adminDesc : String?
    
    var adminId   : Int?
    
    var indsTitle : String?
    var indsAddress : String?
    var indsBio : String?
    var cityModel:CityIndustryModel?
      @IBOutlet var btnMeassage: UIButton!
      @IBOutlet var label_messagCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if resourceKey == "en" {
            setLabelLanguageData(label: languageLbl, key: "english")
        }
        if resourceKey == "ar" {
            setLabelLanguageData(label: languageLbl, key: "arabic")
        }
        if resourceKey == "ckb" {
            setLabelLanguageData(label: languageLbl, key: "kurdish")
        }
        selectLangOutletBtn.backgroundColor = .lightGray
        selectLangOutletBtn.isEnabled = false
        
        setButtonLanguageData(button: workingBtn, key: "working hours")
        setButtonLanguageData(button: staffBtn, key: "staff")
        setButtonLanguageData(button: serviceBtn, key: "Services")
        setButtonLanguageData(button: galleryBtn, key: "gallery")
        setButtonLanguageData(button: mapbtn, key: "location")
        setButtonLanguageData(button: commentBtn, key: "comments")
        setButtonLanguageData(button: aboutBtn, key: "about us")
        setButtonLanguageData(button: contactBtn, key: "Contact us")
        setButtonLanguageData(button: switchBtn, key: "Switch industry")
        setButtonLanguageData(button: editIndstryBtn, key: "Edit Industry")
        setButtonLanguageData(button: langBtn, key: "Language")
        setButtonLanguageData(button: logOutBtn, key: "log out")
        setButtonLanguageData(button: shareBtn, key: "share")
        
        
        setLabelLanguageData(label: self.descLab, key: "description")
        setLabelLanguageData(label: self.nameLab, key: "Name")
        //   setLabelLanguageData(label: self.emailLab, key: "Email")
        setLabelLanguageData(label: self.label_Interoduce, key: "IntroducerCode")
        setLabelLanguageData(label: self.phoneLab, key: "phone")
        
        
        setLabelLanguageData(label: self.selectLangLab, key: "Select language")
        setLabelLanguageData(label: self.englishLab, key: "english")
        setLabelLanguageData(label: self.kurdishLab, key: "kurdish")
        setLabelLanguageData(label: self.arabicLab, key: "arabic")
        setButtonLanguageData(button: self.selectLangOutletBtn, key: "Select language")
        
        
        
        cornerButton(button: addBtn, cornerValue: 8.0, maskToBounds: true)
        cornerViews(view: selectLangView, cornerValue: 8.0, maskToBounds: true)
        cornerImage(image: profileImage, cornerValue: Float(profileImage.frame.height / 2), maskToBounds: true)
        cornerImage(image: logoImage, cornerValue: 16.0, maskToBounds: true)
        cornerButton(button: logOutBtn, cornerValue: 8.0, maskToBounds: true)
        logOutBtn.layer.borderWidth = 0.8
        logOutBtn.layer.borderColor = greenColor.cgColor
        
        setMessageLanguageData(&settingPageTitle, key: "setting")
        self.navigationItem.title = settingPageTitle
        
        btnSuggestion.setTitle(setMessage(key: "Suggest Salon"), for: .normal)
        btnGroup.setTitle(setMessage(key: "Introducer"), for: .normal)
        
        navigationController?.navigationBar.tintColor = .black
        
        setMessageLanguageData(&navigationEdit, key: "Edit")
        let editAppt = UIBarButtonItem(title: navigationEdit, style: .plain, target: self, action: #selector(editProfile))
        navigationItem.rightBarButtonItem = editAppt
        btnMeassage.setTitle(setMessage(key: "message"), for:.normal)
        
        label_messagCount.layer.cornerRadius = 30/2
        label_messagCount.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        label_messagCount.text = "\(UserDefaults.standard.getMessageCount())"
    }
    @objc func editProfile () {
        performSegue(withIdentifier: "toEditProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditProfile"{
            let destVC = segue.destination as! EditProfileVC
            destVC.passedName = self.adminName
            destVC.passedEmail = self.adminEmail
//            destVC.passedBirthday = self.adminBirtday
            destVC.passedGender = self.adminGender
        }

        if segue.identifier == "toAbout"{
            let destVC = segue.destination as! AboutUsVC
            destVC.passedtext = addressString ?? ""
        }
        if segue.identifier == "toComments"{
            let destVC = segue.destination as! CommentsVC
            destVC.passedProviderId = (adminId ?? 1)
        }
        if segue.identifier == "toEditIndustry"{
            let destVC = segue.destination as! EditIndustryVC
            destVC.passedTitle = self.indsTitle
            destVC.passedbio = self.indsBio
            destVC.passedAddress = self.indsAddress
            destVC.cityModel = cityModel
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
//********************************** fetch data *****************************
    func fetchData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Industry")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if (results.count) > 0 {
                for result in results as! [NSManagedObject] {
                    if let industryid = result.value(forKey: "industryId") as? Int {
                        industryID = industryid
                        print("industryid: \(String(describing: industryID))")
                    }

                    if let address = result.value(forKey: "businessAddress") as? String, let phone = result.value(forKey: "businessPhone") as? String, let title = result.value(forKey: "businessTitle") as? String, let catId = result.value(forKey: "categoryId") as? Int {
                        bussinesAddress = address
                        bussinessPhone = phone
                        bussinesTitle = title
                        selectedCategoryId = catId
                    }
                }
            }
        }catch{
            //
        }

        let tokenRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        tokenRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(tokenRequest)
            if (results.count) > 0 {
                for result in results as! [NSManagedObject] {
                    if let token = result.value(forKey: "token") as? String {
                        accesssToken = token
                        print("token: \(String(describing: accesssToken))")
                        getProfile()
                        getIndustryData()
                    }
                }
            }
        }catch{
            //
        }
    }
    
// ********************************** Profile **********************************
    func getProfile(){
        let profileUrl = baseUrl + "profile"
        print(profileUrl)
        ServiceAPI.shared.fetchGenericData(urlString: profileUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: profileModell?, error:Error?,status:Int?) in

//            print(status)
            if status == 200 {
                let profile = model?.data
//                print(profile)
                print(model?.data?.name ?? "")

                self.adminName = profile?.name ?? "admin name"
                self.adminNameLabel.text = (profile?.name ?? "admin name")

             //   self.adminEmail = profile?.email ?? "admin email"
             //   self.adminEmailLabel.text = (profile?.email ?? "admin email")

                self.adminPhone = profile?.phone ?? "admin phone"

                self.adminPhoneLabel.text = (profile?.phone ?? "admin phone")
                self.adminDesc =  (profile?.description ?? "no Description")
                self.label_Value_Interoduce.text = profile?.introduce_code


                
                let gender = profile?.gender
                if gender == 1 {
                    self.adminGender = "Male"
                }else{
                    self.adminGender = "Female"
                }

                let url = NSURL(string: profile?.avatar?.url_sm ?? "")
                if url != nil {
                    self.profileImage.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named: "user.png"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
                }else{
                    self.profileImage.image = UIImage(named: "user.png")
                }
            }else if status == 401 || status == 404 {
                setMessageLanguageData(&unacouticated, key: "Unauthenticated! Please logOut and login again")
                self.displayAlertMsg(userMsg: unacouticated)
            }
            else{
                setMessageLanguageData(&someThingWentWrong, key: "Some thing went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
// ********************************** show an industry **********************************
    
    func getIndustryData(){

        let industryUrl = baseUrl + "industries/" + "\(industryID ?? 0)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: showIndustryModel?, error:Error?,status:Int?) in
     
//            print(status)
            if status == 200 {
                let showIndustryDetails = model?.data
//                print(showIndustryDetails)

                settingServicesList = showIndustryDetails?.services ?? []
                serviceCount = settingServicesList.count
                
                settingStaffList = showIndustryDetails?.staff ?? []
                self.adminId = settingStaffList.first{$0.name == self.adminName}?.id ?? 1
//                print(self.adminId)
                
                settingWorkHours = showIndustryDetails?.working_hours ?? []
                settingGallery = showIndustryDetails?.gallery ?? []

                providerLat = model?.data?.lat ?? ""
                providerLng = model?.data?.lng ?? ""

                self.indsTitle = showIndustryDetails?.title ?? ""

                self.indsAddress = showIndustryDetails?.address
                self.addressLab.text = self.indsAddress

                self.indsBio = showIndustryDetails?.description
                self.descriptionLabel.text = (self.indsBio ?? "No Bio")
                self.cityModel = showIndustryDetails?.city

            }else if status == 401 || status == 404 {
                setMessageLanguageData(&unacouticated, key: "Unauthenticated")
                let message = swiftyJsonVar["message"].string ?? unacouticated
                self.displayAlertMsg(userMsg: message)
            }else{
                setMessageLanguageData(&noIndustryInactive, key: "No Industery save for you! It may still be inactive")
                self.displayAlertMsg(userMsg: noIndustryInactive)
            }
        }
    }
    
    @IBAction func addProfileImageTapped(_ sender: Any) {
        
        setMessageLanguageData(&photoSource, key: "Photo Source")
        setMessageLanguageData(&chooseImage, key: "Choose Images")
        setMessageLanguageData(&photoLibrary, key: "Photo Library")
        setMessageLanguageData(&cancell, key: "Cancel")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: photoSource, message: chooseImage, preferredStyle: .actionSheet)
        //        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
        //            if UIImagePickerController.isSourceTypeAvailable(.camera){
        //                imagePickerController.sourceType = .camera
        //                self.present(imagePickerController, animated: true, completion: nil)
        //            }else {
        //                print("Camera not Avalible!!")
        //            }
        //        }))
        actionSheet.addAction(UIAlertAction(title: photoLibrary, style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: cancell, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if #available(iOS 11.0, *) {
            if let url = info[.imageURL] as? NSURL{
                uploadImage(urlLocal: url as URL)
            }
        } else {

        }
        self.dismiss(animated: true, completion: nil)
    }

    func uploadImage(urlLocal: URL){
        loading()
        let uploadImageUrl = baseUrl + "uploadAvatar"
        print(uploadImageUrl)
        let uploadImgParam : Parameters = ["avatar": "", "manner": "image"]

        print(urlLocal)
        ServiceAPI.shared.uploadAvatar(apiUrl: uploadImageUrl, urlLocal: urlLocal.absoluteURL, parameters: emptyParam) { (result:Result<MessageModel>) in
            self.dismissLoding()
            switch result {
            case .success(let model, let status):
                if status == 200 {
                    setMessageLanguageData(&successUploded, key: "Successfully Uploaded")
                    self.displaySuccessMsg(userMsg: successUploded)
                }
            case .failure(let error, let status, let message):
                setMessageLanguageData(&ImageSize, key: "Your image size must less than 5 MB")
                self.displayAlertMsg(userMsg: ImageSize)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func workingHourTapped(_ sender: Any) {
        performSegue(withIdentifier: "toHours", sender: self)
    }
    
    @IBAction func staffTapped(_ sender: Any) {
        performSegue(withIdentifier: "toStaff", sender: self)
    }
    
    @IBAction func serviceTapped(_ sender: Any) {
        performSegue(withIdentifier: "toService", sender: self)
    }
    
    @IBAction func galleryTapped(_ sender: Any) {
        performSegue(withIdentifier: "toGallery", sender: self)
    }
    
   
    @IBAction func shareAppTapped(_ sender: Any) {
        let objectsToShare = ["https://apps.apple.com/us/app/umaass/id1482503635","Umaass Provider"] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }

    
    
    
    @IBAction func commentsTapped(_ sender: Any) {
        performSegue(withIdentifier: "toComments", sender: self)
    }
    
    @IBAction func editIndustryTapped(_ sender: Any) {
        performSegue(withIdentifier: "toEditIndustry", sender: self)
    }
    
    @IBAction func aboutusTapped(_ sender: Any) {
        loading()
        var aboutUrl = String()
        if resourceKey == "ckb" {
            aboutUrl = "http://umaass.com/api/page/about?lang=ku"
        }else{
            aboutUrl = "http://umaass.com/api/page/about?lang=" + resourceKey
        }
        ServiceAPI.shared.fetchGenericData(urlString: aboutUrl, parameters: emptyParam, methodInput: .get) { (model: rulseAboutModel?, error, status) in
            self.dismissLoding()
            if status == 200 {
                self.addressString = model?.rulesdata
                print(self.addressString ?? "")
                self.performSegue(withIdentifier: "toAbout", sender: self)
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: self)
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        setMessageLanguageData(&logout, key: "Are you sure logout your account")
        displayQuestionMsg(userMsg: logout)
    }
    
    @IBAction func switchIndustryTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "switchIndustry") as? SwitchIndustryVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func callToQdorTapped(_ sender: Any) {
        performSegue(withIdentifier: "toContactUs", sender: self)
    }
    
    func displayQuestionMsg(userMsg: String){
        
        setMessageLanguageData(&yes, key: "yes")
        setMessageLanguageData(&no, key: "no")
        
        let myAlert = UIAlertController(title: "" ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: yes, style: .default, handler: { action in
            self.logOut()
        }))
        let cancelAction = (UIAlertAction(title: no, style: .cancel, handler: { action in
            print("kojaaaa dadaaaaa bemon pishemoon")
        }))
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displaySuccessMsg(userMsg: String){
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = myTabBar
        }))
    }
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func logOut(){
        let request: NSFetchRequest<User> = User.fetchRequest()
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

        //--------- version deleted
        let requestt: NSFetchRequest<Industry> = Industry.fetchRequest()
        do {
            let resultss = try context.fetch(requestt)
            for result in resultss as [NSManagedObject] {
                context.delete(result)
                print("Industry Data: \(resultss) is deleted")
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

        let reloadPage = self.storyboard?.instantiateViewController(withIdentifier: "SplashScreen")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = reloadPage

    }

// -------------------------------- Animation -------------------------------
  
    @IBAction func changeLanguageTapped(_ sender: Any) {
        popAnimationIn(popView: selectLangView)
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        selectLangOutletBtn.backgroundColor = .lightGray
        selectLangOutletBtn.isEnabled = false
        popAnimateOut(popView: selectLangView)
    }
    
    @IBAction func englishTapped(_ sender: Any) {
        selectLangOutletBtn.backgroundColor = greenColor
        selectLangOutletBtn.isEnabled = true
        englishIconBtn.setImage(UIImage(named: "selectOn"), for: .normal)
        kurdishIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
        arabicIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
        turkishIconButton.setImage(UIImage(named: "selectOff"), for: .normal)
        
        appLang = "English"
        resourceKey = "en"
    }
    
    @IBAction func kurdishTapped(_ sender: Any) {
        selectLangOutletBtn.backgroundColor = greenColor
        selectLangOutletBtn.isEnabled = true
        englishIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
        kurdishIconBtn.setImage(UIImage(named: "selectOn"), for: .normal)
        arabicIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
        turkishIconButton.setImage(UIImage(named: "selectOff"), for: .normal)
        
        appLang = "Kurdish"
        resourceKey = "ckb"
    }
    
    @IBAction func arabicTapped(_ sender: Any) {
        selectLangOutletBtn.backgroundColor = greenColor
        selectLangOutletBtn.isEnabled = true
        englishIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
        kurdishIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
        arabicIconBtn.setImage(UIImage(named: "selectOn"), for: .normal)
        turkishIconButton.setImage(UIImage(named: "selectOff"), for: .normal)
        
        appLang = "Arabic"
        resourceKey = "ar"
    }
    
    @IBAction func turkish(_ sender: Any) {
         
         englishIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
         kurdishIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
         arabicIconBtn.setImage(UIImage(named: "selectOff"), for: .normal)
         turkishIconButton.setImage(UIImage(named: "selectOn"), for: .normal)
         
         appLang = "Turkish"
         resourceKey = "tr"
         
     }
    
    @IBAction func selectLanguageTapped(_ sender: Any) {
        
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
        
        
        popAnimateOut(popView: selectLangView)
        if resourceKey == "en" {
            setLabelLanguageData(label: languageLbl, key: "english")
        }
        if resourceKey == "ar" {
            setLabelLanguageData(label: languageLbl, key: "arabic")
        }
        if resourceKey == "ckb" {
            setLabelLanguageData(label: languageLbl, key: "kurdish")
        }
        if resourceKey == "tr"{
            setLabelLanguageData(label: languageLbl, key: "turkish")
        }
        saveLanguage(language: appLang, languageCode: resourceKey)
        self.saveChangelanguge()
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
    
    
}



var logout = String()
var noIndustryInactive = String()
var ImageSize = String()
