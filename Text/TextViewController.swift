//
//  TextViewController.swift
//  Text
//
//  Created by cccUser on 22/05/19.
//  Copyright © 2019 cccUser. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLVision



class TextViewController: UIViewController {

    @IBOutlet weak var img_View: UIImageView!
    
    @IBOutlet weak var text_View: UITextView!
    var textRecognizer: VisionTextRecognizer!
    

    @IBOutlet weak var language_String: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
        navigationItem.title = "Text recognition demo"
    }
    
    @IBAction func btn_Next(_ sender: Any) {
        img_View.image = UIImage(named: "img")
        if(text_View.text != nil){
            text_View.text = ""
        }
    }
    
    @IBAction func btn_identify(_ sender: Any) {
        if(img_View.image != nil){
        runtextRecognization(with: img_View.image!)
        }
        
    }
    func runtextRecognization(with image:UIImage){
        let visionImage = VisionImage(image: image)
        textRecognizer.process(visionImage) { (features, error) in
            self.processResult(from: features, error: error)
            
        }
    }
    
    func processResult(from text:VisionText?,error:Error?){
        guard let features = text, let image = img_View.image else{ return }
        for block in features.blocks{
            for line in block.lines{
                text_View.text += line.text
                text_View.text += "\n"
//                for element in line.elements{
////                    print("Found_Text---------->",element.text)
////                    print("Found_Count---------->",element.recognizedLanguages.count)
////                    text_View.text += element.text
////                    text_View.text += "\n"
//
//                }
            }
            
        }
        RefgText(text: text_View.text)
        
    }
    
    func RefgText(text:String)  {

        let languageId = NaturalLanguage.naturalLanguage().languageIdentification()

        languageId.identifyLanguage(for: text_View.text) { (languageCode, error) in
            if let error = error {
                print("Failed with error: \(error)")
                return
            }
            if let languageCode = languageCode, languageCode != "und" {
                print("Identified Language: \(languageCode)")
                self.language_String.textColor = UIColor.red
                self.language_String.text = languageCode
                
            } else {
                print("No language was identified")
            }
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
