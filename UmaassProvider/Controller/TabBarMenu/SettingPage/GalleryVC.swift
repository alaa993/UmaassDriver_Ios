//
//  GalleryVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class GalleryVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var noItemLabel: UILabel!
    
    enum Mode {
        case view
        case select
    }
    
    var mMode : Mode = .view {
        didSet {
            switch mMode {
            case .view:
                selectBarButton.title = "Edit"
                galleryCollection.reloadData()
                navigationItem.leftBarButtonItem = nil
                addBarButton.action = #selector(addImages(_:))
            case .select:
                selectBarButton.title = "Cancel"
                galleryCollection.reloadData()
                addBarButton.action = nil
//                navigationItem.leftBarButtonItem = deleteBarButton
            }
        }
    }
    var pickedImage            : UIImage?
    var imagesArr              = [UIImage]()
    var imageIdToDelete        : Int?
    var celltag                = 0
    var imgUrl                 : String?
    
    
    lazy var selectBarButton : UIBarButtonItem = {
        setMessageLanguageData(&navigationEdit, key: "Edit")
        let barButtonItem = UIBarButtonItem(title: navigationEdit, style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barButtonItem
    }()
    
    lazy var addBarButton : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImages(_:)))
        return barButtonItem
    }()
    
    //    lazy var deleteBarButton : UIBarButtonItem = {
    //        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
    //        return barButtonItem
    //    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItem()
        galleryCollection.layer.cornerRadius = 6.0
        galleryCollection.layer.masksToBounds = true
        
        if settingGallery.count > 0 {
            loading()
            galleryCollection.isHidden = false
            noItemLabel.isHidden = true
            galleryCollection.reloadData()
            self.dismissLoding()
        }else{
            galleryCollection.isHidden = true
            noItemLabel.isHidden = false
        }
        
        setLabelLanguageData(label: noItemLabel, key: "No item")
        setMessageLanguageData(&galleryPageTitle, key: "gallery")
        self.navigationItem.title = galleryPageTitle
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        
    }
    
    
    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
        mMode = mMode == .view ? .select : .view
    }
    
   
    
    func setUpBarButtonItem(){
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: view.frame.width / 2, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
        navigationItem.setRightBarButtonItems([addBarButton, selectBarButton], animated: true)
    }
    
    
    let imagePickerController = UIImagePickerController()
    @objc func addImages(_ sender: UIBarButtonItem) {
        
        setMessageLanguageData(&photoSource, key: "Photo Source")
        setMessageLanguageData(&chooseImage, key: "Choose Images")
        setMessageLanguageData(&photoLibrary, key: "Photo Library")
        setMessageLanguageData(&cancell, key: "Cancel")
        
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: photoSource, message: chooseImage, preferredStyle: .actionSheet)
        //        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
        //            if UIImagePickerController.isSourceTypeAvailable(.camera){
        //                self.imagePickerController.sourceType = .camera
        //                self.imagePickerController.allowsEditing = true
        //                self.present(self.imagePickerController, animated: true, completion: nil)
        //            }else {
        //                print("Camera not Avalible!!")
        //            }
        //        }))
        actionSheet.addAction(UIAlertAction(title: photoLibrary, style: .default, handler: { (action:UIAlertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: cancell, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

//
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
            // version ....
        }

        self.dismiss(animated: true, completion: nil)
    }




    func uploadImage(urlLocal: URL){
        loading()
        let uploadImageUrl = baseUrl + "industries/uploadImage"
        print(uploadImageUrl)
        let uploadImgParam : Parameters = ["industry_id": industryID ?? "", "manner": "gallery"]

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
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // ********************************* image Collection View ************************
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (galleryCollection.frame.width / 2) - 12
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionCell", for: indexPath) as! GalleryCollectionViewCell
        cell.layer.cornerRadius = 6.0
        cell.layer.masksToBounds = true
        cell.galleryImg.layer.cornerRadius = 6.0
        cell.galleryImg.layer.masksToBounds = true
        cell.layer.masksToBounds = false
        
        if mMode == .select {
            cell.deleteImg.isHidden = false
        }else{
            cell.deleteImg.isHidden = true
        }
        
        let imageUrl = settingGallery[indexPath.row].url_sm ?? ""
        getImage(urlStr: imageUrl, img: cell.galleryImg)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if mMode == .view {
            imgUrl = settingGallery[indexPath.row].url_sm ?? ""
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "showImage") as? ShowImagesVC {
                vc.passedImgUrl = imgUrl
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            imageIdToDelete = settingGallery[indexPath.row].id
            setMessageLanguageData(&deleteItem, key: "Are you sure to delete item")
            displayQuestionMsg(userMsg: deleteItem)
        }
    }
    
    
    
    func displayQuestionMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.loading()
            let deleteImageUrl = baseUrl + "industries/deleteImage?id=" + "\(self.imageIdToDelete ?? 1)"

            print(deleteImageUrl)
            print(accesssToken)
            var headers:HTTPHeaders = [
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
                        setMessageLanguageData(&successfullyDeleted, key: "Your image Successfully Deleted")
                        self.displaySuccessMsg(userMsg: successfullyDeleted)
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
        
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            self.getGalleryImages()
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
    
// ********************************** get gallery  **********************************
    func getGalleryImages(){
        loading()
        let industryUrl = baseUrl + "industries/" + "\(industryID!)"
        print(industryUrl)
        ServiceAPI.shared.fetchGenericData(urlString: industryUrl, parameters: emptyParam, methodInput: .get, isHeaders: true) { (model: showIndustryModel?, error:Error?,status:Int?) in
            self.dismissLoding()
            print(status)
            if status == 200 {
                let showIndustryDetails = model?.data
                settingGallery = showIndustryDetails?.gallery ?? []
                self.galleryCollection.reloadData()
            }else{
                setMessageLanguageData(&someThingWentWrong, key: "something went wrong")
                self.displayAlertMsg(userMsg: someThingWentWrong)
            }
        }
    }
}


