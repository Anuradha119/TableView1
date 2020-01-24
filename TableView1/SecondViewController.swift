//
//  SecondViewController.swift
//  TableView1
//
//  Created by Marni Anuradha on 12/24/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var imageInData:Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      fillTextFields()
        
        // Do any additional setup after loading the view.
        
    }
    

    
    @IBAction func onGalleryBtnTap(_ sender: UIButton) {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum)){
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            
            print(pickedImage)
            
            imageButton.setBackgroundImage(pickedImage, for: UIControl.State.normal)
            
            imageInData = pickedImage.pngData()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func fillTextFields(){
        
        if let index = ViewController.rowIndex
        {
            nameTF.text = ViewController.name[index]
            
            ageTF.text = String(ViewController.age[index])
            emailTF.text = ViewController.email[index]
            imageButton.setBackgroundImage(ViewController.image[index], for: UIControl.State.normal)
        }
    }
    
    @IBAction func onSaveButtonTap(_ sender: UIButton) {
        
        if(ViewController.rowIndex == nil)
        {
            
            CRUD.insertValue(entityName: "PersonalDetails", key1: "name", value1: nameTF.text!, key2: "email", value2: emailTF.text!, key3: "age", value3: Int16(ageTF.text!)!, key4: "picture", value4: imageInData)
        

        }
        else{
            
        }
        
    }
}
