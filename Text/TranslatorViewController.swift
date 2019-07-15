//
//  TranslatorViewController.swift
//  Text
//
//  Created by cccUser on 31/05/19.
//  Copyright © 2019 cccUser. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLCommon

class TranslatorViewController: UIViewController {
    
    @IBOutlet weak var btn_AutoDetectCutom: UIButton!
    @IBOutlet weak var language_Detected: UILabel!
    @IBOutlet weak var btn_TranslateCutom: UIButton!
    @IBOutlet weak var select_Language: UITextField!
    @IBOutlet weak var second_TextVierw: UITextView!
    @IBOutlet weak var First_textView: UITextView!

    var text = ""
    var Englih = TranslateLanguage.EN
    var Chinees = TranslateLanguage.ZH
    var customView = UIView()
    var selectedLanguage:Int = 0
    
    var languages = ["English","Chinees"]
    var llll:[TranslateLanguage] = [TranslateLanguage.EN,TranslateLanguage.ZH]
    var Lang: TranslateLanguage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDayPicker()
        createToolbar()
        CalendarIconView()
        CutomViews()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 35/255, green: 51/255, blue: 159/255, alpha: 1)
        self.navigationItem.title = "Digi Translator"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func CutomViews() {
        
        First_textView.layer.borderWidth = 0.4
        First_textView.layer.borderColor = UIColor.black.cgColor
        First_textView.layer.cornerRadius = 10
        First_textView.clipsToBounds = true
        
        second_TextVierw.layer.borderWidth = 0.4
        second_TextVierw.layer.borderColor = UIColor.black.cgColor
        second_TextVierw.layer.cornerRadius = 10
        second_TextVierw.clipsToBounds = true
        
        select_Language.layer.borderWidth = 0.4
        select_Language.layer.borderColor = UIColor.black.cgColor
        select_Language.layer.cornerRadius = 10
        select_Language.clipsToBounds = true

        
        btn_TranslateCutom.layer.shadowColor = UIColor.darkGray.cgColor
        btn_TranslateCutom.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        btn_TranslateCutom.layer.shadowOpacity = 4.0
        btn_TranslateCutom.layer.shadowRadius = 1
        btn_TranslateCutom.layer.masksToBounds = false
        btn_TranslateCutom.layer.cornerRadius = 4.0
        
        btn_AutoDetectCutom.layer.shadowColor = UIColor.darkGray.cgColor
        btn_AutoDetectCutom.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        btn_AutoDetectCutom.layer.shadowOpacity = 4.0
        btn_AutoDetectCutom.layer.shadowRadius = 1
        btn_AutoDetectCutom.layer.masksToBounds = false
        btn_AutoDetectCutom.layer.cornerRadius = 4.0
        
    }
     func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func CalendarIconView()
{
    let img:UIImage = UIImage(named: "Dropdown")!
    let imgView:UIImageView = UIImageView(image: img)
    imgView.frame = CGRect(x: -15, y: -5, width: 10, height: 15)
    imgView.contentMode = .center
    customView.addSubview(imgView)
    select_Language.rightView = customView
    select_Language.rightViewMode = .always
    }
    
    func createDayPicker() {
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        select_Language.inputView = dayPicker
        dayPicker.backgroundColor = .gray 
    }
    
    @IBAction func btn_AutoDetect(_ sender: Any) {
        
        if(First_textView.text != "" ){
    RefgText(text:First_textView.text)
        }else{
            showAlertMessage(vc: self, titleStr: "Empty", messageStr: "Please Enter the Text to Translate")
        }
    }
    func RefgText(text:String)  {
        
        let languageId = NaturalLanguage.naturalLanguage().languageIdentification()
        
        languageId.identifyLanguage(for: First_textView.text) { (languageCode, error) in
            if let error = error {
                print("Failed with error: \(error)")
                return
            }
            if let languageCode = languageCode, languageCode != "und" {
                print("Identified Language: \(languageCode)")
                self.language_Detected.textColor = UIColor.red
                self.language_Detected.text = languageCode
                
            } else {
                print("No language was identified")
            }
        }
    }
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = UIColor(red: 35/255, green: 51/255, blue: 159/255, alpha: 1)
        
        toolBar.tintColor = UIColor.white//UIColor(red: 35/255, green: 51/255, blue: 159/255, alpha: 1)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TranslatorViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        select_Language.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        
        select_Language.text = text
        view.endEditing(true)
    }

    @IBAction func btn_Translate(_ sender: Any) {
        
        if(First_textView.text != ""){
        // Create an English-German translator:
         let lan:String =  self.First_textView.text
        
        let options = TranslatorOptions(sourceLanguage:.ZH, targetLanguage: .EN)
        let englishTamilTranslator = NaturalLanguage.naturalLanguage().translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        englishTamilTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }
            
            // Model downloaded successfully. Okay to start translating.
           
                
                englishTamilTranslator.translate(lan) { translatedText, error in
                    guard error == nil, let translatedText = translatedText else { return }
                    
                    // Translation succeeded.
                    self.second_TextVierw.text = translatedText
            }
           
        }
    }
        else{
            showAlertMessage(vc: self, titleStr: "Empty", messageStr: "Please Enter the Text to Translate")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TranslatorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedLanguage = row
        if(selectedLanguage == 1){
           Lang = TranslateLanguage.EN
        }
        //LanguageSelected.text = languages[row]
    
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 17)
        
        label.text = languages[row]
         text = label.text!
        //select_Language.text! = lable.text!
        return label
    }
}




