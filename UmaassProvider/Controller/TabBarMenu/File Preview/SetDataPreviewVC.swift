//
//  SetDataPreviewVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/13/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage



class SetDataPreviewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var clientImage: UIImageView!
    @IBOutlet weak var applicantNameLabel: UILabel!
    @IBOutlet weak var callNumberOutlet: UIButton!
    @IBOutlet weak var patientNameLbl: UILabel!
//    @IBOutlet weak var patientAgeLbl: UILabel!
    @IBOutlet weak var patientGenderLbl: UILabel!
    @IBOutlet weak var patientCallNumberOutlet: UIButton!
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var apptDateLabel: UILabel!
    @IBOutlet weak var apptTimeLabel: UILabel!

    @IBOutlet weak var attachedCollectionView   : UICollectionView!
    @IBOutlet weak var prescriptionText         : UITextView!
    @IBOutlet weak var editWidth                : NSLayoutConstraint!
    @IBOutlet weak var noItemLabel: UILabel!
    
    @IBOutlet weak var editOutlet               : UIButton!
    @IBOutlet weak var AddImageOutlet           : UIButton!
    @IBOutlet weak var attacheLab: UILabel!
    
    
    @IBOutlet weak var nameLab: UILabel!
//    @IBOutlet weak var ageLab: UILabel!
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var genderLab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    
    
    
    var passedApptId           : Int?
    var passedClientName       : String?
    var passedClientPhone      : String?
    var passedDate             : String?
    var passedTime             : String?
    var passedService          : String?
    var passedClientAvatar     : String?
    var timeEdited             : Bool = false
    var pickedImage            : UIImage?
    var imagesArr              = [UIImage]()
    var imageIdToDelete        : Int?
    var celltag                = 0
    var imgUrl                 : String?
    var isEdited               : Bool = true
    var applicantNumber           : String?
    var patientCall            : String?
    var fileReviewSeccessfullyUpdated = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        getAppoinmetPreviewDetails()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelLanguageData(label: nameLab, key: "Name")
//        setLabelLanguageData(label: ageLab, key: "age")
        setLabelLanguageData(label: descLab, key: "description")
        setLabelLanguageData(label: genderLab, key: "Gender")
        setLabelLanguageData(label: phoneLab, key: "phone")
        setLabelLanguageData(label: noItemLabel, key: "No item")
        setLabelLanguageData(label: attacheLab, key: "attached file")
        setButtonLanguageData(button: editOutlet, key: "Edit")
        setButtonLanguageData(button: AddImageOutlet, key: "add image")
        
        
        noItemLabel.isHidden = true
        attachedCollectionView.isHidden = true
        prescriptionText.layer.cornerRadius = 4.0
        prescriptionText.layer.masksToBounds = true
        
        setMessageLanguageData(&setDataReviewPageTitle, key: "set data review")
        self.navigationItem.title = setDataReviewPageTitle
        

        
        cornerImage(image: clientImage, cornerValue: Float(clientImage.frame.height / 2), maskToBounds: true)
        cornerButton(button: editOutlet, cornerValue: 4.0, maskToBounds: true)
        editOutlet.layer.borderWidth = 0.4
        editOutlet.layer.borderColor = greenColor.cgColor
        cornerButton(button: AddImageOutlet, cornerValue: 4.0, maskToBounds: true)
        AddImageOutlet.layer.borderWidth = 0.4
        AddImageOutlet.layer.borderColor = greenColor.cgColor
        
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
        
        setMessageLanguageData(&navigationSave, key: "save")
        let saveEdit = UIBarButtonItem(title: navigationSave, style: .plain, target: self, action: #selector(saveFileReview))
        navigationItem.rightBarButtonItem = saveEdit
        setData()
    }
    
    
    @objc func saveFileReview () {
        loading()
        let saveApptsUrl = baseUrl + "appointments/" + "\(passedApptId ?? 0)"
        print(saveApptsUrl)
        
        var saveApptsParams = [String : Any]()
        saveApptsParams = [
            "prescription" : prescriptionText.text ?? "",
            "status"       : "done"
            ] as [String : Any]
        
        print(saveApptsParams)
        
        let header = [
            "Authorization": "Bearer \(accesssToken)",
            "X-Requested-With": "application/json",
            "Content-type" : "application/json",
            "Accept" : "application/json"
        ]
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: saveApptsParams, options: [])
            let request = NSMutableURLRequest(url: NSURL(string: saveApptsUrl)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "PUT"
            request.allHTTPHeaderFields = header
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                self.dismissLoding()
                if ((data) != nil) {
                    let httpResponse = response as? HTTPURLResponse
                    let status = (httpResponse?.statusCode)
                    print(status)
                    if status == 200 {
                        let json = JSON(data)
                        print(json)
                        DispatchQueue.main.async {
                            setMessageLanguageData(&self.fileReviewSeccessfullyUpdated, key: "File Preview Successfully Updated")
                            self.displaySuccessMsg(userMsg: self.fileReviewSeccessfullyUpdated)
                        }
                    }else if status == 422 {
                        DispatchQueue.main.async {
                            setMessageLanguageData(&invalidData, key: "Invalid Data")
                            self.displayAlertMsg(userMsg: invalidData)
                        }
                    }else{
                        setMessageLanguageData(&someThingWentWrong, key: "somthing went wrong")
                        self.displayAlertMsg(userMsg: someThingWentWrong)
                    }
                } else {
                    setMessageLanguageData(&someThingWentWrong, key: "somthing went wrong")
                    self.displayAlertMsg(userMsg: someThingWentWrong)
                }
            })
            dataTask.resume()
        }catch{
            
        }
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if isEdited == true {
            isEdited = false
            editOutlet.setTitle("Cancel", for: .normal)
            self.attachedCollectionView.reloadData()
            editWidth.constant = 60
        }else{
            isEdited = true
            editOutlet.setTitle("Edit", for: .normal)
            self.attachedCollectionView.reloadData()
            editWidth.constant = 40
        }
    }
    
    let imagePickerController = UIImagePickerController()
    
    @IBAction func addImageTapped(_ sender: Any) {
        
        setMessageLanguageData(&photoSource, key: "Photo Source")
        setMessageLanguageData(&chooseImage, key: "Choose Images")
        setMessageLanguageData(&photoLibrary, key: "Photo Library")
        setMessageLanguageData(&cancell, key: "Cancel")
        
        
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: photoSource, message: chooseImage, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: photoLibrary, style: .default, handler: { (action:UIAlertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: cancell, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("ok")
        if #available(iOS 11.0, *) {
            if (imagePickerController.sourceType == .camera) {
                if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    pickedImage = image
                } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    pickedImage = image
                }
                let imgName = UUID().uuidString
                let documentDirectory = NSTemporaryDirectory()
                let localPath = documentDirectory.appending(imgName)
                print(localPath)
                let url = URL(fileURLWithPath: localPath) as NSURL
                print(url)
                uploadImage(urlLocal: url as URL)
            }else{
                if let url = info[.imageURL] as? NSURL{
                    uploadImage(urlLocal: url as URL)
                }
            }
        } else {
            // version .....
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // ************************************ upload Images ***********************************
    
    func uploadImage(urlLocal: URL){
        loading()
        let uploadImageUrl = baseUrl + "appointments/" + "\(passedApptId ?? 1)" + "/image"
        print(uploadImageUrl)
        let uploadImgParam : Parameters = ["manner": "appointment"]
        
        print(uploadImgParam)
        print(urlLocal)
        ServiceAPI.shared.uploadFile(apiUrl: uploadImageUrl, urlLocal: urlLocal.absoluteURL, parameters: uploadImgParam) { (result:Result<MessageModel>) in
            self.dismissLoding()
            switch result {
            case .success(let model, let status):
                if status == 200 {
                    setMessageLanguageData(&successUploded, key: "Successfully Uploaded")
                    self.displaySuccessMsg(userMsg: successUploded)
                }
            case .failure(let error, let status, let message):
                setMessageLanguageData(&yourimageSize, key: "Your image size must less than 5 MB")
                self.displayAlertMsg(userMsg: yourimageSize)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func setData() {
        
        self.applicantNameLabel.text = passedClientName
        self.serviceNameLabel.text = passedService
        self.apptDateLabel.text = passedDate
        self.apptTimeLabel.text = passedTime
        self.callNumberOutlet.setTitle(passedClientPhone, for: .normal)
        
        let url = NSURL(string: self.passedClientAvatar ?? "")
        if url != nil {
            self.clientImage.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named: "user.png"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
        }else{
            self.clientImage.image = UIImage(named: "user.png")
        }
    }
    
    
    // ******************************** appointment details ***********************************
    
    func getAppoinmetPreviewDetails() {
        //        loading()
        let appoinmentDetailsUrl = baseUrl + "appointments/" + "\(passedApptId ?? 1)"
        print(appoinmentDetailsUrl)
        
        ServiceAPI.shared.fetchGenericData(urlString: appoinmentDetailsUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: ApptReviewDetailsModel?, error:Error?,status:Int?) in
            //            self.uploadImagedismissLoding()
            if status == 200 {
                let ApptReviewDetailsList = model?.data
                fliePreviewAttaches.removeAll()
                fliePreviewAttaches = ApptReviewDetailsList?.images ?? []
                
                self.patientNameLbl.text = ApptReviewDetailsList?.client_name ?? "client name"
                
//                self.patientAgeLbl.text = "\(ApptReviewDetailsList?.client_age ?? 30)"
                
                let gender = (ApptReviewDetailsList?.client_gender ?? 1)
                if gender == 1 {
                    self.patientGenderLbl.text = "Male"
                }else{
                    self.patientGenderLbl.text = "Female"
                }
                
                self.patientCall = ApptReviewDetailsList?.client_phone ?? ""
                self.patientCallNumberOutlet.setTitle(self.patientCall, for: .normal)
                
                self.applicantNameLabel.text = ApptReviewDetailsList?.applicant?.name ?? "applicant Name"
                self.serviceNameLabel.text = ApptReviewDetailsList?.service?.title ?? "Service Name"
                
                let date = ApptReviewDetailsList?.start_time ?? ""
                let separateDate = date.split(separator: " ")
                if separateDate.count > 0 {
                    self.apptDateLabel.text = "\(String(describing: separateDate[0]))"
                    self.apptTimeLabel.text = "\(String(describing: separateDate[1]))"
                }
                
                self.applicantNumber = ApptReviewDetailsList?.applicant?.phone ?? ""
                self.callNumberOutlet.setTitle(self.applicantNumber, for: .normal)
                getImage(urlStr: ApptReviewDetailsList?.applicant?.avatar?.url_sm ?? "", img: self.clientImage)
                
                if fliePreviewAttaches.count > 0 {
                    self.attachedCollectionView.reloadData()
                    self.noItemLabel.isHidden = true
                    self.attachedCollectionView.isHidden = false
                }else{
                    self.noItemLabel.isHidden = false
                    self.attachedCollectionView.isHidden = true
                }
                
                
                if ApptReviewDetailsList?.prescription == "" {
                    self.prescriptionText.text = "Description ..."
                    self.prescriptionText.textColor = UIColor.lightGray
                }else{
                    self.prescriptionText.text = ApptReviewDetailsList?.prescription ?? "no prescription data"
                    self.prescriptionText.textColor = UIColor.black
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    @IBAction func callTapped(_ sender: Any) {
        let url: NSURL = URL(string: ("TEL://" + (self.applicantNumber ?? "")))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    @IBAction func patientCallTapped(_ sender: Any) {
        let url: NSURL = URL(string: ("TEL://" + (self.patientCall ?? "")))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    
    // ---------------------------------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if prescriptionText.textColor == UIColor.lightGray && prescriptionText.isFirstResponder {
            prescriptionText.text = ""
            prescriptionText.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if prescriptionText.text.isEmpty || prescriptionText.text == "" {
            prescriptionText.textColor = UIColor.lightGray
            prescriptionText.text = "Prescription ..."
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            prescriptionText.resignFirstResponder()
            return false
        }
        return true
    }
    
    // ************************** attached collection **************************
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fliePreviewAttaches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let attachedFileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "attachedCollectionCell", for: indexPath) as! attachedCollectionViewCell
        
        cornerViews(view: attachedFileCell.mainView, cornerValue: 6.0, maskToBounds: true)
        cornerViews(view: attachedFileCell.attachesImage, cornerValue: 6.0, maskToBounds: true)
        
        if isEdited == true {
            attachedFileCell.deleteImg.isHidden = true
        }else{
            attachedFileCell.deleteImg.isHidden = false
        }
        
        
        let attachedImages = fliePreviewAttaches[indexPath.row].url_sm ?? ""
        let url = NSURL(string: attachedImages)
        if url != nil {
            attachedFileCell.attachesImage.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named: ""), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
        }else{
            attachedFileCell.attachesImage.image = UIImage(named: "")
        }
        return attachedFileCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEdited == false {
            imageIdToDelete = fliePreviewAttaches[indexPath.row].id
            setMessageLanguageData(&deleteItem, key: "Are you sure to delete item")
            displayQuestionMsg(userMsg: deleteItem)
        }else{
            imgUrl = fliePreviewAttaches[indexPath.row].url_sm ?? ""
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "showImage") as? ShowImagesVC {
                vc.passedImgUrl = imgUrl
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (attachedCollectionView.frame.width / 3 ) - 12
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    
    func displayQuestionMsg(userMsg: String){
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.loading()
            let deleteImageUrl = baseUrl + "appointments/" + "\(self.passedApptId ?? 1)" + "/image/" + "\(self.imageIdToDelete ?? 1)"
            
            print(deleteImageUrl)
            print(accesssToken)
            let headers:HTTPHeaders = [
                "Authorization": "Bearer \(accesssToken)",
                "X-Requested-With": "application/json",
                "Content-type" : "application/json",
                "Accept" : "application/json"
            ]
            
            Alamofire.request(deleteImageUrl, method: .delete, headers: headers).responseJSON { response in
                self.dismissLoding()
                if let value: AnyObject = response.result.value as AnyObject? {
                    let post = JSON(value)
                    print(post)
                    let status = response.response?.statusCode
                    print(status)
                    if status == 200 {
                        print("ok")
                        setMessageLanguageData(&deleteImage, key: "Your image Successfully Deleted")
                        self.displaySuccessMsg(userMsg: deleteImage)
                    }
                }
            }
        }))
        let cancelAction = (UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
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
        let myAlert = UIAlertController(title: successfullyDone, message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.getAppoinmetPreviewDetails()
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
}



var fliePreviewAttaches = [ApptReviewDetailsImages]()

fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

var deleteItem = String()
var deleteImage = String()
var edit = String()
