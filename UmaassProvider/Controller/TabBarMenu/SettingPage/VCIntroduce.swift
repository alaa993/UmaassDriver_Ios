//
//  VCIntroduce.swift
//  QDorProvider
//
//  Created by AlaanCo on 7/11/20.
//  Copyright © 2020 Hesam. All rights reserved.
//

import UIKit
import CountryList

class VCIntroduce: UIViewController,DelegateIntroduce{
    
    var countryList = CountryList()
    var codeCountry = "+964"
    @IBOutlet var label_title_introduce: UILabel!
    @IBOutlet var view_add_interoduce: UIView!
    @IBOutlet var textField_Introduce: UITextField!
    @IBOutlet var btnCancell: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnCountry: UIButton!
    var blackView = UIView()
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var viewMian: UIView!
    @IBOutlet var lbCount: UILabel!
    @IBOutlet var lbSum: UILabel!
    var model:ModelIntroduce?
    var sumPrice  = 0
    var count = 0
    var idProvider:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          initView()
          countryList.delegate = self

    }
    
    func initView(){
        
        viewMian.layer.cornerRadius = 8
        viewMian.layer.shadowColor = UIColor.gray.cgColor
        viewMian.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewMian.layer.shadowRadius = 3.0
        viewMian.layer.shadowOpacity = 0.5
        
        btnCountry.layer.borderColor = UIColor.gray.cgColor
        btnCountry.layer.borderWidth = 1
        btnCountry.layer.cornerRadius = 5
        btnCountry.setTitle("+964", for: .normal)
        
        btnSave.setTitle(setMessage(key: "add"), for: .normal)
        btnCancell.setTitle(setMessage(key: "cancel"), for: .normal)
        textField_Introduce.placeholder = "447732830221"
        label_title_introduce.text = setMessage(key: "enternumber")
        
        btnSave.layer.cornerRadius = 5
        btnSave.layer.masksToBounds = true
        
        btnCancell.layer.cornerRadius = 5
        btnCancell.layer.masksToBounds = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        self.navigationItem.title = setMessage(key: "Introducer")
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
         getData()
     }
    
    func comment(model: Introduce?) {
        
        if model?.staffs?.count ?? 0 > 0 {
            idProvider = model?.staffs?[0].id ?? 0
            performSegue(withIdentifier: "comment", sender: self)
        }
        
    }
    
    func delete(model: Introduce?) {
        if model?.staffs?.count ?? 0 > 0 {
            dialogDeleteDoctor(userId: model?.staffs?[0].user_id ?? 0)
        }
    }
    @IBAction func action_view_interoduce(sender: UIButton) {
        switch sender.tag {
        case 1:
            let navController = UINavigationController(rootViewController: countryList)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        case 2:
            if textField_Introduce.text == "" || textField_Introduce.text?.count == 0 {
                return
            }
           self.addDoctor(phone: "\(codeCountry)\(textField_Introduce.text ?? "")")
             popAnimateOut(popView: view_add_interoduce)
        case 3:
            popAnimateOut(popView: view_add_interoduce)
        default:
            print("")
        }
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        
         popAnimationIn(popView: view_add_interoduce)
//     dialogAddDoctor()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         if segue.identifier == "comment"{
             let destVC = segue.destination as! CommentsVC
             destVC.passedProviderId = idProvider
         }
    
     }
    
//    func dialogAddDoctor(){
//
//        let alert = UIAlertController(title: "", message: setMessage(key: "enternumber"), preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.placeholder = "447732830221"
//        }
//        alert.addAction(UIAlertAction(title: setMessage(key:"add"), style: .destructive, handler: { [weak alert] (_) in
//            guard let textField = alert?.textFields?[0] else {return}
//            self.addDoctor(phone: "+\(textField.text ?? "")")
//
//        }))
//
//        alert.addAction(UIAlertAction(title: setMessage(key:"cancel"), style: .cancel, handler: { _ in
//
//        }))
//
//        self.present(alert, animated: true, completion: nil)
//
//    }
    
    func dialogDeleteDoctor(userId:Int){
        
        let alert = UIAlertController(title: "", message:setMessage(key:"removepersonsubcategory"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:setMessage(key: "yes"), style: .default, handler: { _ in
            
            self.deleteSubsetDoctor(user_id: userId)
        }))
        alert.addAction(UIAlertAction(title:setMessage(key: "no"), style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    func addDoctor(phone:String)  {
        
         let url = baseUrl+"referal/add"
        let parameters:[String:Any] = ["mobile":phone]
         self.loading()
         ServiceAPI.shared.fetchGenericData(urlString: url, parameters: parameters, methodInput: .patch,isHeaders: true)
         { ( model:ModelIntroduce?, error:Error?, status:Int?) in
             self.dismissLoding()
            if status == 406 {
                self.displayAlertMsg(userMsg: setMessage(key: "anotherintroducer"))
            }else if status == 422 {
                self.displayAlertMsg(userMsg: setMessage(key: "pleasetryagain"))
            }else {
                self.displayAlertMsg(userMsg: setMessage(key: "requestsuccessfully"))
            }
             
         }
    
    }

    func deleteSubsetDoctor(user_id:Int) {
    
        let url = baseUrl+"referal/remove"
         let parameters:[String:Any] = ["user_id":user_id]
          self.loading()
          ServiceAPI.shared.fetchGenericData(urlString: url, parameters: parameters, methodInput: .patch,isHeaders: true)
          { ( model:ModelIntroduce?, error:Error?, status:Int?) in
              self.dismissLoding()
              if status == 422 {
                 self.displayAlertMsg(userMsg: setMessage(key: "pleasetryagain"))
                return
             }
            
            self.getData()
              
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
    
    
    func getData()  {
        
        self.sumPrice = 0
        let url = baseUrl+"children"
        self.loading()
        ServiceAPI.shared.fetchGenericData(urlString: url, parameters: emptyParam, methodInput: .get,isHeaders: true)
        { ( model:ModelIntroduce?, error:Error?, status:Int?) in
            self.dismissLoding()
            
            if error != nil {
                return
            }
            self.model = model
            self.collectionView.reloadData()
            self.model?.data?.forEach({ (item) in
                self.sumPrice = self.sumPrice+(item.income ?? 0)
            })
   
            self.lbCount.text = "\(setMessage(key: "Count")) : \(self.model?.data?.count ?? 0)"
            self.lbSum.text = "\(setMessage(key: "Sumprice")) : \(self.sumPrice)"
            
        }
    }
    
}


extension VCIntroduce : CountryListDelegate {
    
    func selectedCountry(country: Country) {
        codeCountry = "+\(country.phoneExtension)"
        btnCountry.setTitle("\(codeCountry)", for: .normal)
    }
}

extension VCIntroduce:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroduceCell", for: indexPath) as! IntroduceCell
        cell.model = model?.data?[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
         return CGSize(width: collectionView.frame.width, height: 117)
        
    }

    
}

extension VCIntroduce {
    
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
    
    
}
