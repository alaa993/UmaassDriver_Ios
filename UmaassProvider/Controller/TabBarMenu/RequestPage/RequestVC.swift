//
//  RequestVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var requestTableView: UITableView!
    @IBOutlet weak var noItemLabel: UILabel!

    
    var appoinmentList       = [allAppoinmentData]()
    var moreAppoinmentList   = [allAppoinmentData]()
    var currentDate          : String?
    var selectApptId         : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabelLanguageData(label: noItemLabel, key: "No item")
        
        requestTableView.isHidden = true
        noItemLabel.isHidden = true
        navigationController?.navigationBar.tintColor = .black
        cornerLabel(label: noItemLabel, cornerValue: 10.0, maskToBounds: true)
        
        checkIntroduced()
        
        setMessageLanguageData(&RequestPageTitle, key: "request")
        self.navigationItem.title = RequestPageTitle
        
        navigationController?.navigationBar.tintColor = .black
        requestTableView.isHidden = true
        unreadMessag()
        
       

    }
    

    override func viewWillAppear(_ animated: Bool) {
        getAllAppoinmet()
        i = 2
    }
    
// *********************************** get all appoinments  ******************************************
    
    func getAllAppoinmet() {
        loading()
        let appoinmentUrl = baseUrl + "appointments?status=pending"
        print(appoinmentUrl)

        //        let requestApptparam: Parameters = [
        //            "status"            : "Pending"
        //        ]
        
        
        
        ServiceAPI.shared.fetchGenericData(urlString: appoinmentUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: allAppoinmentModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            
            if status == 200 {
                self.appoinmentList = model?.data ?? []
                print(self.appoinmentList)

                if self.appoinmentList.count > 0 {
                    self.requestTableView.isHidden = false
                    self.noItemLabel.isHidden = true
                    self.requestTableView.reloadData()
                }else{
                    self.noItemLabel.isHidden = false
                    self.requestTableView.isHidden = true
                }
            }
            else if status == 401 || status == 404 {
                setMessageLanguageData(&unacouticated, key: "Unauthenticated! Please log out and login again")
                self.displayAlertMsg(userMsg: unacouticated)
                self.noItemLabel.isHidden = false
                self.requestTableView.isHidden = true
            }
            else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }

        }
    }

    var i : Int = 2
    func loadMoreAppointment(){
        loading()
        let appoinmentUrl = baseUrl + "appointments?status=pending&page=" + "\(i)"
        print(appoinmentUrl)


        ServiceAPI.shared.fetchGenericData(urlString: appoinmentUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: allAppoinmentModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            print(status)
            if status == 200 {
                self.moreAppoinmentList = model?.data ?? []
                if self.moreAppoinmentList.count > 0 {
                    for i in 0..<self.moreAppoinmentList.count {
                        self.appoinmentList.append(self.moreAppoinmentList[i])

                    }
                    self.i = self.i + 1
                    self.requestTableView.reloadData()
                }
            }else if status == 401 || status == 404 {
                setMessageLanguageData(&unacouticated, key: "Unauthenticated! Please log out and login again")
                self.displayAlertMsg(userMsg: unacouticated)
                self.requestTableView.isHidden = true
                self.noItemLabel.isHidden = false
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
    
    //***************************** Request List ***********************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appoinmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reqCell = tableView.dequeueReusableCell(withIdentifier: "RequestTableCell", for: indexPath) as! RequestTableViewCell
        
        reqCell.PatientLabel.text = self.appoinmentList[indexPath.row].client_name ?? "client"
        reqCell.providerNameLabel.text = self.appoinmentList[indexPath.row].applicant?.name ?? "applicant Name"

        reqCell.serviceNameLabel.text = self.appoinmentList[indexPath.row].service?.title ?? "Service"
        let status = self.appoinmentList[indexPath.row].status
        switch status {
        case "pending":
            reqCell.statusImage.image = pendingIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "pending")
            let dateTime = self.appoinmentList[indexPath.row].from_to ?? "no Date selected!"
            let separate = dateTime.split(separator: " ")
            if separate.count > 0 {
                reqCell.timeLabel.text = "\(String(describing: separate[1]))"
                reqCell.dateLabel.text = "\(String(describing: separate[0]))"
            }

        case "no-show":
            reqCell.statusImage.image = noShowIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "no show")
            let dateTime = self.appoinmentList[indexPath.row].start_time ?? "no Date selected!"
            let separate = dateTime.split(separator: " ")
            if separate.count > 0 {
                reqCell.timeLabel.text = "\(String(describing: separate[1]))"
                reqCell.dateLabel.text = "\(String(describing: separate[0]))"
            }
        case "confirmed":
            reqCell.statusImage.image = confirmIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "confirmed")
            let dateTime = self.appoinmentList[indexPath.row].start_time ?? "no Date selected!"
            let separate = dateTime.split(separator: " ")
            if separate.count > 0 {
                reqCell.timeLabel.text = "\(String(describing: separate[1]))"
                reqCell.dateLabel.text = "\(String(describing: separate[0]))"
            }
        case "done":
            reqCell.statusImage.image = doneIcon
            setLabelLanguageData(label: reqCell.AppoinmentStatusLabel, key: "Done")
            let dateTime = self.appoinmentList[indexPath.row].start_time ?? "no Date selected!"
            let separate = dateTime.split(separator: " ")
            if separate.count > 0 {
                reqCell.timeLabel.text = "\(String(describing: separate[1]))"
                reqCell.dateLabel.text = "\(String(describing: separate[0]))"
            }
        default:
            print("ok")
        }

        if indexPath.row == self.appoinmentList.count - 1{
            self.loadMoreAppointment()
        }
        
        return reqCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectApptId = self.appoinmentList[indexPath.row].id ?? 1
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetails") as? AppointmentDetailsVC {
            vc.passedApptId = selectApptId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
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



extension RequestVC {
    
    func checkIntroduced(){
    
        let referal = baseUrl + "referal"
        ServiceAPI.shared.fetchGenericData(urlString: referal, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: ReferalModel?, error:Error?,status:Int?) in

            if status == 200 {
                model?.data?.forEach({ (item) in
                    self.dialogShowReferal(id: item.id ?? 0, name: item.user?.name ?? "")
                })
            }
        }
        
    }
 
    func dialogShowReferal(id:Int,name:String){

        let title = String(format: setMessage(key: "introducer"),name)
         let alert = UIAlertController(title: "", message:title, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title:setMessage(key: "yes"), style: .default, handler: { _ in
             
            self.approvedAndReject(status: "APPROVED", id: id)
            
         }))
         alert.addAction(UIAlertAction(title:setMessage(key: "no"), style: .cancel, handler: { _ in
         self.approvedAndReject(status: "REJECT", id: id)
            
         }))
         self.present(alert, animated: true)
         
     }

    func approvedAndReject(status:String,id:Int){
      
          let referal = baseUrl + "referal/\(id)/status"
          let parameters:[String:Any] = ["status":status]
          loading()
          ServiceAPI.shared.fetchGenericData(urlString: referal, parameters: parameters, methodInput: .patch, isHeaders: true) { (model: ReferalModel?, error:Error?,status:Int?) in
             self.dismissLoding()
              if status == 200 {
                  
              }
          }
          
      }
    
    func unreadMessag()  {
          
          ServiceAPI.shared.fetchGenericData(urlString: baseUrl+"notifications?unread",parameters: [:], methodInput: .get, isHeaders: true) {(model:ModelNotificationMessage?, error:Error?,status:Int?) in
              
              if model?.data?.count  ?? 0 > 0 {
                  let model = model?.data?.filter {$0.app == "Provider" && !$0.read!}
                  UserDefaults.standard.setMessageCount(value: model?.count ?? 0)
              }
              
          }
          
      }
    
}
