//
//  FilePreviewVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/13/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

import Alamofire

class FilePreviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameText           : UITextField!
    @IBOutlet weak var previewTableView   : UITableView!

    @IBOutlet weak var noItemLabel        : UILabel!
    
    var allCustomersList           = [PreviewCustomerData]()
    var loadMoreAllCustomersList   = [PreviewCustomerData]()
    var selectApptId               : Int?
    var selectCustomerId           : Int?
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setTextHintLanguageData(text: nameText, key: "search customer name")
        setLabelLanguageData(label: noItemLabel, key: "No item")
        
        setMessageLanguageData(&reviewPageTitle, key: "File preview")
        self.navigationItem.title = reviewPageTitle
        
        navigationController?.navigationBar.tintColor = .black
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//            navigationItem.largeTitleDisplayMode = .always
//            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
//        } else {
//            // Fallback on earlier versions
//        }
        
        
        //        previewTableView.isHidden = true
        noItemLabel.isHidden = true

        navigationController?.navigationBar.tintColor = .black
        
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
        getAllCustomer()
        i = 2
    }
    
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        if nameText.text == "" || nameText.text!.isEmpty {
            setMessageLanguageData(&enterYourName, key: "Enter your name")
            self.displayAlertMsg(userMsg: enterYourName)
        }else{
            getAllCustomer()
        }
    }
    
    // ******************************** Fetch all customers ***********************************
    func getAllCustomer() {
        name = nameText.text ?? "all"
        loading()
        let allCustomersUrl = baseUrl + "customers"
        let requestApptparam: Parameters = ["name" : name]
        print(allCustomersUrl)
        ServiceAPI.shared.fetchGenericData(urlString: allCustomersUrl, parameters: requestApptparam, methodInput: .get, isHeaders: true) { (model: PreviewCustomerModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            print(status)
            if status == 200 {
                self.allCustomersList = model?.data ?? []
                print(self.allCustomersList)
                
                if self.allCustomersList.count > 0 {
                    self.previewTableView.isHidden = false
                    self.noItemLabel.isHidden = true
                    self.previewTableView.reloadData()
                }else{
                    self.noItemLabel.isHidden = false
                    self.previewTableView.isHidden = true
                }
            }else if status == 401 || status == 404{
                setMessageLanguageData(&unacouticated, key: "Unauthenticated! Please logOut and login again")
                self.displayAlertMsg(userMsg: unacouticated)
                self.noItemLabel.isHidden = false
                self.previewTableView.isHidden = true
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    
    var i : Int = 2
    func loadMoreFilePreview(){
        name = nameText.text ?? "all"
        loading()
        let allCustomersUrl = baseUrl + "customers?page=" + "\(i)"
        let requestApptparam: Parameters = ["name" : name]
        print(allCustomersUrl)
        ServiceAPI.shared.fetchGenericData(urlString: allCustomersUrl, parameters: requestApptparam, methodInput: .get, isHeaders: true) { (model: PreviewCustomerModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            print(status)
            if status == 200 {
                self.loadMoreAllCustomersList = model?.data ?? []
                if self.loadMoreAllCustomersList.count > 0 {
                    for i in 0..<self.loadMoreAllCustomersList.count {
                        self.allCustomersList.append(self.loadMoreAllCustomersList[i])
                        
                    }
                    self.i = self.i + 1
                    self.previewTableView.reloadData()
                }
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                let message = swiftyJsonVar["message"].string
                self.displayAlertMsg(userMsg: message ?? someThingWentWrong)
                self.previewTableView.isHidden = true
                self.noItemLabel.isHidden = false
            }
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCustomersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let previewCell = tableView.dequeueReusableCell(withIdentifier: "PreviewTableCell", for: indexPath) as! PreviewTableViewCell
        
        previewCell.paitientNameLabel.text = allCustomersList[indexPath.row].name ?? "Name"
        previewCell.numberOutlet.setTitle(allCustomersList[indexPath.row].phone, for: .normal)
        let customerImage = allCustomersList[indexPath.row].avatar?.url_sm ?? ""
        let url = NSURL(string: customerImage)
        if url != nil {
            previewCell.avatar.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named: ""), filter: nil, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
        }else{
            previewCell.avatar.image = UIImage(named: "")
        }
        
        if indexPath.row == self.allCustomersList.count - 1{
            self.loadMoreFilePreview()
        }
        //        previewCell.previewCellDelegate = self
        
        return previewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCustomerId = self.allCustomersList[indexPath.row].id ?? 1
        apliname = self.allCustomersList[indexPath.row].name ?? ""
        print(apliname)
        aplinum = self.allCustomersList[indexPath.row].phone ?? ""
        apliImg = self.allCustomersList[indexPath.row].avatar?.url_sm ?? ""
        performSegue(withIdentifier: "toDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let destVC = segue.destination as! PreviewDetailsVC
            destVC.passedUserId = selectCustomerId ?? 1
        }
    }
    
    
    // ------------------------------ text filed -------------------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameText {
            nameText.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        getAllCustomer()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //    func sharePreview(cell: UITableViewCell) {
    //        let index = self.previewTableView.indexPath(for: cell)!
    //        print(index)
    //    }
    //
    //    func deletePreview(cell: UITableViewCell) {
    //        let index = self.previewTableView.indexPath(for: cell)!
    //        print(index)
    //    }
    //
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
}
var apliname = String()
var aplinum = String()
var apliImg = String()
