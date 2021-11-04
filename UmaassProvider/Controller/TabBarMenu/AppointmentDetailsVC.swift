//
//  AppointmentDetailsVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class AppointmentDetailsVC: UIViewController , UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var suggestionAppointsTable: UITableView!
    @IBOutlet weak var suggestBtnOutlet: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var applicantNameLabel: UILabel!
    @IBOutlet weak var numberBtnOutlet: UIButton!
    @IBOutlet weak var patientGenderLbl: UILabel!
    
    @IBOutlet weak var PatientNameLabel: UILabel!
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var deletApptBtn: UIButton!
    
    @IBOutlet weak var fileReviewOutlet: UIButton!
    
    @IBOutlet weak var statusImage    : UIImageView!
    @IBOutlet weak var statusBtnOutlet: UIButton!
    
    @IBOutlet var statusView         : UIView!
    @IBOutlet weak var confirmView   : UIView!
    @IBOutlet weak var noShowView    : UIView!
    @IBOutlet weak var pendingView   : UIView!
    @IBOutlet weak var doneView      : UIView!
    
    @IBOutlet weak var date          : UILabel!
    @IBOutlet weak var time          : UILabel!
    
    
    @IBOutlet weak var confirmLab: UILabel!
    @IBOutlet weak var noShowLab: UILabel!
    @IBOutlet weak var pendingLab: UILabel!
    @IBOutlet weak var doneLab: UILabel!
    @IBOutlet weak var changeStatusLabe: UILabel!
    
    
    
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var requestLab: UILabel!
    @IBOutlet weak var genderLab: UILabel!
    @IBOutlet weak var serviceLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    
    
    
    
    var blackView                = UIView()
    var passedApptId             : Int?
    var ApptDetailsList          = [ApptDetailsData]()
    var suggestionList           = [SuggestionData]()
    var selectedStartSuggestion  : String?
    var selectedEndSuggestion    : String?
    var number                   : String?
    var saveMessage              : String?
    var appoinmentId             : Int?
    var reqsStatusPicker         = UIPickerView()
    var reqsStatusToolBar        = UIToolbar()
    
    var newStatus                : String?
    var start                    = String()
    var end                      = String()
    
    var timeEdited               : Bool = false
    
    var clientName       : String?
    var applicantPhone      : String?
    var apptDate         : String?
    var apptTime         : String?
    var apptService      : String?
    var clientAvatar     : String?
    var isSuggest : String?
    
    var apptStatus = String()
    
    var youMustChangeStatus = String()
    var youMustConfirmedRequest = String()
    var doyouRejectAppt = String()
    var successfullyRejected = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLanguageData(label: nameLab,key: "Name")
        setLabelLanguageData(label: genderLab,key: "Gender")
        setLabelLanguageData(label: requestLab, key: "request")
        setLabelLanguageData(label: serviceLab,key: "Service")
        setLabelLanguageData(label: dateLab, key: "date")
        setLabelLanguageData(label: timeLab, key: "time")
        
        setButtonLanguageData(button: statusBtnOutlet, key: "status")
        setButtonLanguageData(button: fileReviewOutlet, key: "File preview")
        setButtonLanguageData(button: suggestBtnOutlet, key: "Suggestion appointments")
        setButtonLanguageData(button: deletApptBtn, key: "Delete")
        
        setLabelLanguageData(label: confirmLab,key: "confirmed")
        setLabelLanguageData(label: noShowLab, key: "no show")
        setLabelLanguageData(label: pendingLab,key: "pending")
        setLabelLanguageData(label: doneLab, key: "Done")
        setLabelLanguageData(label: changeStatusLabe, key: "Change Appointment Status")
        
        newStatus = ""
        apptStatus = ""
        isSuggest = ""
        self.fileReviewOutlet.isHidden = true
        print(passedApptId)
        
        setMessageLanguageData(&appointmentDetailsPageTitle, key: "Appointment Details")
        self.navigationItem.title = appointmentDetailsPageTitle
        
        suggestionAppointsTable.isHidden = true
        
        statusBtnOutlet.layer.borderColor = greenColor.cgColor
        cornerButton(button: statusBtnOutlet, cornerValue: 4.0, maskToBounds: true)
        
        cornerButton(button: suggestBtnOutlet, cornerValue: 6.0, maskToBounds: true)
        cornerImage(image: userImage, cornerValue: Float(userImage.frame.height / 2), maskToBounds: true)
        cornerViews(view: statusView, cornerValue: 6.0, maskToBounds: true)
        cornerViews(view: confirmView, cornerValue: 4.0, maskToBounds: true)
        cornerViews(view: noShowView, cornerValue: 4.0, maskToBounds: true)
        cornerViews(view: pendingView, cornerValue: 4.0, maskToBounds: true)
        cornerViews(view: doneView, cornerValue: 4.0, maskToBounds: true)
        
        cornerButton(button: fileReviewOutlet, cornerValue: 4.0, maskToBounds: true)
        fileReviewOutlet.layer.borderWidth = 0.4
        fileReviewOutlet.layer.borderColor = greenColor.cgColor
        
        getAppoinmetDetails()

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
        let saveEdit = UIBarButtonItem(title: navigationSave, style: .plain, target: self, action: #selector(saveAppoinment))
        
        navigationItem.rightBarButtonItem = saveEdit
    }
    
    // --------------------------------- save appointment ------------------------------
    @objc func saveAppoinment () {

        print(newStatus)
        print(apptStatus)

        if apptStatus == "pending" {
            if newStatus == "" {
                setMessageLanguageData(&youMustChangeStatus, key: "you must change status and then save")
                self.displayAlertMsg(userMsg: youMustChangeStatus)
            }
            if newStatus == "confirmed" {
                if isSuggest == "ok"{
                    newStatus = "confirmed"
                    submitAppointment()
                }else{
                    timeEdited = true
                    selectedStartSuggestion = self.suggestionList[0].start ?? ""
                    selectedEndSuggestion = self.suggestionList[0].end ?? ""
                    
                    let separateStartDate = selectedStartSuggestion?.split(separator: " ")
                    if (separateStartDate?.count ?? 0) > 0 {
                        self.fromDateLabel.text = "\(separateStartDate![0])"
                        self.fromTimeLabel.text = "\(separateStartDate![1])"
                    }
                    submitAppointment()
                    
                   // self.displayAlertMsg(userMsg: "you must select suggest appointment date and time and then save!")
                }
            }
            if newStatus == "done" {
                setMessageLanguageData(&youMustConfirmedRequest, key: "you must confirmed the request")
                self.displayAlertMsg(userMsg: youMustConfirmedRequest)
            }
            if newStatus == "no-show" {
                setMessageLanguageData(&youMustConfirmedRequest, key: "you must confirmed the request")
                self.displayAlertMsg(userMsg: youMustConfirmedRequest)
            }
        }


        if apptStatus == "confirmed" {
            if newStatus == "pending" {

            }

            if newStatus == "" && isSuggest == "ok" {
                newStatus = "confirmed"
                submitAppointment()
            }
            if newStatus == "done" {
                submitAppointment()
            }
            if newStatus == "no-show" {
                submitAppointment()
            }
        }

        if apptStatus == "done" {

        }

        if apptStatus == "no-show" {

        }
    }

    func submitAppointment(){
        loading()
        let saveApptsUrl = baseUrl + "appointments/" + "\(passedApptId ?? 0)"
        print(saveApptsUrl)
        
        let newDateTimeMode = newDateTime(start: selectedStartSuggestion ?? self.suggestionList[0].start ?? "" , end: selectedEndSuggestion ?? self.suggestionList[0].end ?? "")
        let model = updateApptData(status: newStatus ?? "confirmed", new_date_time: newDateTimeMode)
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(model)
            jsonEncoder.outputFormatting = .prettyPrinted
            
            let url = URL(string: saveApptsUrl)
            var request = URLRequest(url: url!)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            JSONEncoding.default
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(accesssToken)",
                "X-Requested-With": "application/json",
                "Content-type" : "application/json",
                "Accept" : "application/json"
            ]
            print(jsonData)
            Alamofire.request(request).responseJSON {
                (response) in
                self.dismissLoding()
                
                
                if (response.result.value) != nil {
                    let swiftyJsonVar = JSON(response.result.value)
                    print("swiftyJsonVar ---------- ",swiftyJsonVar)
                    
                    print(response)
                    let status = response.response?.statusCode
                    print(status)
                    
                    if status == 200 {
                        self.dismissLoding()
                        setMessageLanguageData(&successUpdated, key: "Successfully Done")
                        self.displaySuccessMsg(userMsg: successUpdated)
                    }else if status == 422 {
                        setMessageLanguageData(&invalidData, key: "Invalid Data")
                        self.displayAlertMsg(userMsg: invalidData)
                    }else{
                        setMessageLanguageData(&someThingWentWrong, key: "somthing went wrong")
                        self.displayAlertMsg(userMsg: someThingWentWrong)
                    }
                } else {
                    self.dismissLoding()
                    setMessageLanguageData(&thereIsNoData, key: "There is no data")
                    self.displayAlertMsg(userMsg: thereIsNoData)
                }
            }
        }catch {
            
        }
    }
    
    
    

// ******************************** appointment details ***********************************
    
    func getAppoinmetDetails() {
        loading()
        let appoinmentDetailsUrl = baseUrl + "appointments/" + "\(passedApptId ?? 1)"
        print(appoinmentDetailsUrl)

        ServiceAPI.shared.fetchGenericData(urlString: appoinmentDetailsUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: ApptDetailsModel?, error:Error?,status:Int?) in

            self.dismissLoding()

            if status == 200 {
                let ApptDetailsList = model?.data
                //                print(ApptDetailsList)

                self.clientName = ApptDetailsList?.client_name ?? ""
                self.PatientNameLabel.text = self.clientName

                let gender = (ApptDetailsList?.client_gender ?? 1)
                if gender == 1 {
                    setLabelLanguageData(label: self.patientGenderLbl, key: "male")
                }else{
                    setLabelLanguageData(label: self.patientGenderLbl, key: "female")
                }


                self.applicantPhone = ApptDetailsList?.applicant?.phone ?? ""
                self.numberBtnOutlet.setTitle(self.applicantPhone, for: .normal)

                self.number = ApptDetailsList?.client_phone ?? ""
                self.applicantNameLabel.text = ApptDetailsList?.applicant?.name ?? ""

                self.apptService = ApptDetailsList?.service?.title ?? ""
                self.serviceLabel.text = self.apptService
                self.appoinmentId = ApptDetailsList?.id ?? 1


                self.start = ApptDetailsList?.start_time ?? ""
                self.end = ApptDetailsList?.end_time ?? ""


                let avatarImg = ApptDetailsList?.applicant?.avatar?.url_sm ?? ""
                self.clientAvatar = avatarImg
                let url = NSURL(string: avatarImg)
                if url != nil {
                    self.userImage.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named: "user.png"), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
                }else{
                    self.userImage.image = UIImage(named: "user.png")
                }

                self.getSuggestionList()
                self.apptStatus = ApptDetailsList?.status ?? ""
                switch self.apptStatus {
                case "pending":
                    
                    setButtonLanguageData(button: self.statusBtnOutlet, key: "pending")
                    setLabelLanguageData(label: self.date, key: "from date")
                    setLabelLanguageData(label: self.time, key: "from time")
                    self.fileReviewOutlet.isHidden = true
                    self.statusImage.image = pendingIcon
                    let date = ApptDetailsList?.from_to ?? ""
                    let separateDate = date.split(separator: " ")
                    if separateDate.count > 0 {
                        self.apptDate = "\(String(describing: separateDate[0]))"
                        self.apptTime = "\(String(describing: separateDate[1]))"
                        self.fromDateLabel.text = "\(String(describing: separateDate[0]))"
                        self.fromTimeLabel.text = "\(String(describing: separateDate[1]))"
                    }
                case "no-show":
                    setLabelLanguageData(label: self.date, key: "Date appointment")
                    setLabelLanguageData(label: self.time, key: "time appointment")
                    setButtonLanguageData(button: self.statusBtnOutlet, key: "no show")
                    self.statusBtnOutlet.isEnabled = false
                    self.statusBtnOutlet.tintColor = .lightGray
                    self.suggestBtnOutlet.backgroundColor = gray
                    self.suggestBtnOutlet.isEnabled = false
                    self.fileReviewOutlet.isHidden = true
                    self.statusImage.image = noShowIcon
                    let date = ApptDetailsList?.start_time ?? ""
                    let separateDate = date.split(separator: " ")
                    if separateDate.count > 0 {
                        self.apptDate = "\(String(describing: separateDate[0]))"
                        self.apptTime = "\(String(describing: separateDate[1]))"
                        self.fromDateLabel.text = "\(String(describing: separateDate[0]))"
                        self.fromTimeLabel.text = "\(String(describing: separateDate[1]))"
                    }
                case "confirmed":
                    setButtonLanguageData(button: self.statusBtnOutlet, key: "confirmed")
                    setLabelLanguageData(label: self.date, key: "confirmed date")
                    setLabelLanguageData(label: self.time, key: "confirmed time")
                    self.fileReviewOutlet.isHidden = true
                    self.statusImage.image = confirmIcon
                    let date = ApptDetailsList?.start_time ?? ""
                    let separateDate = date.split(separator: " ")
                    if separateDate.count > 0 {
                        self.apptDate = "\(String(describing: separateDate[0]))"
                        self.apptTime = "\(String(describing: separateDate[1]))"
                        self.fromDateLabel.text = "\(String(describing: separateDate[0]))"
                        self.fromTimeLabel.text = "\(String(describing: separateDate[1]))"
                    }
                case "done":
                    setLabelLanguageData(label: self.date, key: "Date appointment")
                    setLabelLanguageData(label: self.time, key: "time appointment")
                    setButtonLanguageData(button: self.statusBtnOutlet, key: "Done")
                    self.statusBtnOutlet.isEnabled = false
                    self.statusBtnOutlet.tintColor = .lightGray

                    self.suggestBtnOutlet.backgroundColor = gray
                    self.suggestBtnOutlet.isEnabled = false
                    self.fileReviewOutlet.isHidden = false
                    self.statusImage.image = doneIcon
                    let date = ApptDetailsList?.start_time ?? ""
                    let separateDate = date.split(separator: " ")
                    if separateDate.count > 0 {
                        self.apptDate = "\(String(describing: separateDate[0]))"
                        self.apptTime = "\(String(describing: separateDate[1]))"
                        self.fromDateLabel.text = "\(String(describing: separateDate[0]))"
                        self.fromTimeLabel.text = "\(String(describing: separateDate[1]))"
                    }
                default:
                    print("ok")
                }
            }else{
                setMessageLanguageData(&thereIsNoData, key: "There is no data")
                self.displayAlertMsg(userMsg: thereIsNoData)
            }
        }
    }
    
    @IBAction func callToPatiantTapped(_ sender: Any) {
        let url: NSURL = URL(string: ("TEL://" + (number ?? "")))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    
    //*****************************  suggestion list ***********************************
    
    @IBAction func suggestionAppointTapped(_ sender: Any) {
        suggestionAppointsTable.isHidden = false
    }
    
    func getSuggestionList(){
        let suggectUrl = baseUrl + "appointments/" + "\( passedApptId ?? 0)/suggestions"
        ServiceAPI.shared.fetchGenericData(urlString: suggectUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: SuggestionModel?, error:Error?,status:Int?) in

            if status == 200 {
                self.suggestionList = model?.data ?? []
                if self.suggestionList.count > 0 {
                    self.suggestionAppointsTable.isHidden = true
                    self.suggestionAppointsTable.reloadData()
                }
            }else{
                setMessageLanguageData(&thereIsNoData, key: "There is no data")
                self.displayAlertMsg(userMsg: thereIsNoData)
            }
        }
    }
    
    // --------------------------- suggestion table view -------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.suggestionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let suggCell = tableView.dequeueReusableCell(withIdentifier: "SDuggestTableCell", for: indexPath) as! SDuggestTableViewCell
        
        suggCell.startSuggestionDate.text = self.suggestionList[indexPath.row].start ?? "no time"
        suggCell.endSuggestionDate.text = self.suggestionList[indexPath.row].end ?? "no time"
        
        return suggCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timeEdited = true
        isSuggest = "ok"
        selectedStartSuggestion = self.suggestionList[indexPath.row].start ?? ""
        selectedEndSuggestion = self.suggestionList[indexPath.row].end ?? ""

        newDate.removeAll()
        newDate.append(newDateData(start: selectedStartSuggestion ?? "", end: selectedEndSuggestion ?? ""))
        print(newDate)


        let separateStartDate = selectedStartSuggestion?.split(separator: " ")
        if (separateStartDate?.count ?? 0) > 0 {
            self.fromDateLabel.text = "\(separateStartDate![0])"
            self.fromTimeLabel.text = "\(separateStartDate![1])"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    @IBAction func statusChangeTapped(_ sender: Any) {
        popAnimationIn(popView: statusView)
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        newStatus = "confirmed"
        setButtonLanguageData(button: statusBtnOutlet, key: "confirmed")
        statusImage.image = confirmIcon
        self.suggestBtnOutlet.backgroundColor = greenColor
        self.suggestBtnOutlet.isEnabled = true
        popAnimateOut(popView: statusView)
        self.fileReviewOutlet.isHidden = true
    }
    
    @IBAction func noShowTapped(_ sender: Any) {
        newStatus = "no-show"
        setButtonLanguageData(button: statusBtnOutlet, key: "no show")
        statusImage.image = noShowIcon
        self.suggestBtnOutlet.backgroundColor = gray
        self.suggestBtnOutlet.isEnabled = false
        popAnimateOut(popView: statusView)
        self.fileReviewOutlet.isHidden = true
    }
    
    @IBAction func pendingTapped(_ sender: Any) {
        newStatus = "pending"
        setButtonLanguageData(button: statusBtnOutlet, key: "pending")
        statusImage.image = pendingIcon
        self.suggestBtnOutlet.backgroundColor = greenColor
        self.suggestBtnOutlet.isEnabled = true
        popAnimateOut(popView: statusView)
        self.fileReviewOutlet.isHidden = true
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        newStatus = "done"
        setButtonLanguageData(button: statusBtnOutlet, key: "done")
        statusImage.image = doneIcon
        popAnimateOut(popView: statusView)
        self.suggestBtnOutlet.backgroundColor = gray
        self.suggestBtnOutlet.isEnabled = false
        self.fileReviewOutlet.isHidden = false
    }
    
    @IBAction func dismisPopTapped(_ sender: Any) {
        popAnimateOut(popView: statusView)
    }
    
    
    @IBAction func rejectApptTapped(_ sender: Any) {
        setMessageLanguageData(&doyouRejectAppt, key: "Do you want to reject this Appointment")
        displayQuestionMsg(userMsg: doyouRejectAppt)
    }
    
    @IBAction func fileReviewTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetDataReview") as? SetDataPreviewVC {
            vc.passedApptId = self.passedApptId
            vc.passedClientName = self.clientName
            vc.passedDate = self.apptDate
            vc.passedTime = self.apptTime
            vc.passedService = self.apptService
            vc.passedClientAvatar = self.clientAvatar
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    func displayQuestionMsg(userMsg: String){
        
        setMessageLanguageData(&yes, key: "yes")
        setMessageLanguageData(&no, key: "no")
        
        let myAlert = UIAlertController(title: "" ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: yes, style: .default, handler: { action in
            self.rejectAppointment()
        }))
        let cancelAction = (UIAlertAction(title: no, style: .cancel, handler: { action in
            print("Cancel")
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
            self.dismissLoding()
            self.navigationController?.popViewController(animated: true)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func rejectAppointment(){
        loading()
        let deleteUrl = baseUrl + "appointments/" + "\(appoinmentId ?? 1)"
        print(deleteUrl)
        ServiceAPI.shared.fetchGenericData(urlString: deleteUrl, parameters: emptyParam, methodInput: .delete, isHeaders: true) { (model: MessageModel?, error:Error?,status:Int?) in
            print(status)
            self.dismissLoding()
            if status == 200 {
                setMessageLanguageData(&self.successfullyRejected, key: "Successfully rejected")
                self.displaySuccessMsg(userMsg: self.successfullyRejected)

            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
}

var newDate             : [newDateData] = []
var newSuggestionDate   : [newDateModel] = []

fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}




