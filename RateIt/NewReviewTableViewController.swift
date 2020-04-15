//
//  NewReviewTableViewController.swift
//  RateIt
//
//  Created by Nikita Vesna on 08.03.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import UIKit

class NewReviewTableViewController: UITableViewController {
    
    var newReview: Review?
    var imageIsChaged = false
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var ReviewTF: UITextField!
    
    @IBAction func CancelBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @IBAction func SaveBtnPressed(_ sender: UIBarButtonItem) {
        
        
        /*
        if nameTF.text != "" {
        //
        } else {
            let emptyField = UIAlertController(title: "Name is reqierd", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Fill", style: .default)
            emptyField.addAction(okAction)
            present(emptyField, animated: true) {
                //
            }
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        saveBtn.isEnabled = false
        
        nameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    //MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let libraryIcon = #imageLiteral(resourceName: "photo")
            
            let addPhotoAC = UIAlertController(title: nil,
                                               message: nil, preferredStyle: .actionSheet)
            
            let library = UIAlertAction(title: "Photo Library", style: .default) { _ in
                self.chooseImagePicker(sourse: .photoLibrary)
            }
            library.setValue(libraryIcon, forKey: "image")
            library.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(sourse: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            addPhotoAC.addAction(library)
            addPhotoAC.addAction(camera)
            addPhotoAC.addAction(cancel)
            
            present(addPhotoAC, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func saveNewReview() {
        
        var image: UIImage?
        
        if imageIsChaged {
            image = newReview?.image
        } else {
            image = #imageLiteral(resourceName: "photoDefault")
        }
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        let dateString = dateFormatter.string(from: date as Date)
        
        newReview = Review(name: nameTF.text!,
                           secondField: typeTF.text,
                           date: dateString,
                           image: image)
    }
    
}


extension NewReviewTableViewController: UITextFieldDelegate {
    
    //Hide keyboard on pressing "done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if nameTF.text?.isEmpty == false {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
}

extension NewReviewTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Work with image
    func chooseImagePicker(sourse: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourse) else { return }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourse
        
        if sourse == .camera {
            imagePicker.cameraCaptureMode = .photo
            imagePicker.cameraDevice = .rear
        }
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        dismiss(animated: true)
        
        imageIsChaged = true
    }
    
}

