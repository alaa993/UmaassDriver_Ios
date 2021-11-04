//
//  PreviewDetailsVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/13/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire



class PreviewDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var aplicantAvatarImg      : UIImageView!
    @IBOutlet weak var aplicantNameLbl        : UILabel!
    @IBOutlet weak var PreviewTableView       : UITableView!
    @IBOutlet weak var noItemLabel            : UILabel!

    @IBOutlet weak var aplicantNumberOutlet   : UIButton!
    
    
    var aplicantNumber  : String?
    var passedUserId    : Int?
    var selectedFileId  : Int?
    
    var allApptsFiles       : [AllApptsPreviewData] = []
    var moreAllApptsFiles   : [AllApptsPreviewData] = []
    
    var allApptsFilesDone       : [AllApptsPreviewData] = []
    var moreAllApptsFilesDone   : [AllApptsPreviewData] = []
    
    var toSeeAppt = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMessageLanguageData(&reviewDetailsPageTitle, key: "File preview Details")
        self.navigationItem.title = reviewDetailsPageTitle
        
        //        PreviewTableView.estimatedRowHeight = 130.0
        //        PreviewTableView.rowHeight = UITableView.automaticDimension
        
        cornerImage(image: aplicantAvatarImg, cornerValue: Float(aplicantAvatarImg.frame.height / 2), maskToBounds: true)
        PreviewTableView.isHidden = true
        noItemLabel.isHidden = true
        noItemLabel.text = "No Item"

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllApptsPreview()
        allApptsFiles.removeAll()
        i = 2
    }
    
    // ******************************** Fetch all customers ***********************************
    func getAllApptsPreview() {
        loading()
        let allApptsUrl = baseUrl + "appointments?user_id=" + "\(passedUserId ?? 1)"
        print(allApptsUrl)
        
        ServiceAPI.shared.fetchGenericData(urlString: allApptsUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: AllApptsPreviewMode?, error:Error?,status:Int?) in
            self.dismissLoding()
            //            print(status)
            if status == 200 {
                self.allApptsFiles = model?.data ?? []
                //                print(allApptsFiles)
                
                if self.allApptsFiles.count > 0 {
                    print(self.allApptsFiles.count)
                    print(self.allApptsFiles)
                    
                    self.allApptsFilesDone = self.allApptsFiles.filter{$0.status == "done"}
                    print(self.allApptsFilesDone.count)
                    print(self.allApptsFilesDone)
                    
                    if self.allApptsFilesDone.count > 0 {
                        self.aplicantNameLbl.text = self.allApptsFilesDone[0].applicant?.name ?? "aplicant name"
                        let imageUrl = self.allApptsFilesDone[0].applicant?.avatar?.url_sm ?? ""
                        getImage(urlStr: imageUrl, img: self.aplicantAvatarImg)
                        self.aplicantNumber = self.allApptsFilesDone[0].applicant?.phone ?? ""
                        self.aplicantNumberOutlet.setTitle(self.aplicantNumber, for: .normal)
                        
                        self.PreviewTableView.isHidden = false
                        self.noItemLabel.isHidden = true
                        self.PreviewTableView.reloadData()
                    }else{
                        self.aplicantNameLbl.text = apliname
                        getImage(urlStr: apliImg, img: self.aplicantAvatarImg)
                        self.aplicantNumberOutlet.setTitle(aplinum, for: .normal)
                        self.PreviewTableView.isHidden = true
                        self.noItemLabel.isHidden = false
                    }
                    
                }else{
                    self.aplicantNameLbl.text = apliname
                    getImage(urlStr: apliImg, img: self.aplicantAvatarImg)
                    self.aplicantNumberOutlet.setTitle(aplinum, for: .normal)
                    self.noItemLabel.isHidden = false
                    self.PreviewTableView.isHidden = true
                }
            }else if status == 401 {
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
                self.noItemLabel.isHidden = false
                self.PreviewTableView.isHidden = true
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
            
        }
    }
    
    
    var i : Int = 2
    func loadMoreAllApptsPreview(){
        loading()
        let allApptsUrl = baseUrl + "appointments?page=" + "\(i)" + "&user_id=" + "\(passedUserId ?? 1)"
        print(allApptsUrl)
        
        ServiceAPI.shared.fetchGenericData(urlString: allApptsUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: AllApptsPreviewMode?, error:Error?,status:Int?) in
            self.dismissLoding()
            if status == 200 {
                let morelist = model?.data ?? []
                print(morelist.count)
                print(morelist)
                
                self.moreAllApptsFilesDone = morelist.filter{$0.status == "done"}
                
                if self.moreAllApptsFilesDone.count > 0 {
                    for i in 0..<self.moreAllApptsFilesDone.count {
                        self.allApptsFilesDone.append(self.moreAllApptsFilesDone[i])
                        print(self.allApptsFilesDone.count)
                    }
                    self.i = self.i + 1
                    print(self.i)
                    self.PreviewTableView.reloadData()
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                let message = swiftyJsonVar["message"].string
                self.displayAlertMsg(userMsg: message ?? someThingWentWrong)
                self.PreviewTableView.isHidden = true
                self.noItemLabel.isHidden = false
            }
            
        }
    }
    
    
    
    
    @IBAction func aplicantCallTapped(_ sender: Any) {
        let url: NSURL = URL(string: ("TEL://" + (self.aplicantNumber ?? "")))! as NSURL
        UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    // ****************************** table view ********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allApptsFilesDone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let previewCell = tableView.dequeueReusableCell(withIdentifier: "PreviweDetailsTableCell", for: indexPath) as!  PreviweDetailsTableViewCell
        
        let dateTime = allApptsFilesDone[indexPath.row].start_time ?? "no Date selected!"
        let separate = dateTime.split(separator: " ")
        if separate.count > 0 {
            previewCell.topLabel.text = "\(String(describing: separate[0]))   \(String(describing: separate[1]))" + " - " + (allApptsFiles[indexPath.row].service?.title ?? "Service Name")
        }
        previewCell.descriptipnLabel.text = allApptsFilesDone[indexPath.row].prescription ?? "No Prescription Text"
        previewCell.clientNameLbl.text = allApptsFilesDone[indexPath.row].client_name ?? "client name"
//        previewCell.clientAgeLbl.text = "\(allApptsFilesDone[indexPath.row].client_age ?? 30)"
        
        let status = allApptsFilesDone[indexPath.row].status ?? ""
        previewCell.statusLbl.text = status
        if status == "done" {
            previewCell.mainView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        }else{
            previewCell.mainView.backgroundColor = gray
        }
        
        if indexPath.row == allApptsFilesDone.count - 1{
            self.loadMoreAllApptsPreview()
        }
        
        return previewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ststus = allApptsFilesDone[indexPath.row].status ?? ""
        if ststus == "done" {
            selectedFileId = allApptsFilesDone[indexPath.row].id ?? 1
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetDataReview") as? SetDataPreviewVC {
                vc.passedApptId = selectedFileId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            setMessageLanguageData(&toSeeAppt, key: "To see or edit Appointment file preview, the Appointment should to be in done status")
            self.displayAlertMsg(userMsg: toSeeAppt)
        }
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    
    //    func didSet(cell: UITableViewCell) {
    //        let index = self.PreviewTableView.indexPath(for: cell)!
    //        selectedFileId = allApptsFiles[(index.row)].id ?? 1
    //        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetDataPreview") as? SetDataPreviewVC {
    //            vc.passedApptId = selectedFileId
    //            self.navigationController?.pushViewController(vc, animated: true)
    //        }
    //    }
    
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
}


fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
