//
//  FaceViewController.swift
//  Text
//
//  Created by cccUser on 22/05/19.
//  Copyright © 2019 cccUser. All rights reserved.
//

import UIKit
import Firebase

class FaceViewController: UIViewController {

    @IBOutlet weak var image_View: UIImageView!
    @IBOutlet weak var face_Textview: UITextView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func runFaceRecognization(with image:UIImage){
        
        let vision = Vision.vision()
        let options = VisionFaceDetectorOptions()
        options.performanceMode = .accurate
        options.landmarkMode = .all
        options.classificationMode = .all
        let faceDetector = vision.faceDetector(options: options)
        let visionImage = VisionImage(image: image)
        faceDetector.process(visionImage) { faces, error in
            guard error == nil, let faces = faces, !faces.isEmpty else {
                // ...
                return
            }
            
            for face in faces {
            
                let smile = face.smilingProbability
                if(smile > 0.5){
                    self.face_Textview.text += "Smiling: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "True"
                    self.face_Textview.text += "\n"
                }else{
                    self.face_Textview.text += "Smiling: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "False"
                    self.face_Textview.text += "\n"
                }
               
                
              let leftEyeOpen =   face.leftEyeOpenProbability
                if(leftEyeOpen > 0.5){
                self.face_Textview.text += "Left Eye Open: "
                self.face_Textview.text += "\t"
                self.face_Textview.text += "True"
                self.face_Textview.text += "\n"
                }else{
                    self.face_Textview.text += "Left Eye Open: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "False"
                    self.face_Textview.text += "\n"
                }
                
                let rightEyeOpen =   face.rightEyeOpenProbability
                 if(rightEyeOpen > 0.5){
                self.face_Textview.text += "Right Eye Open: "
                self.face_Textview.text += "\t"
                self.face_Textview.text += "True"
                self.face_Textview.text += "\n"
                 }else{
                    self.face_Textview.text += "Right Eye Open: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "False"
                    self.face_Textview.text += "\n"
                }
            }
            
        }
    }
    
    
    
    
    func runFaceRecognizationSecondFace(with image:UIImage){
        
        let vision = Vision.vision()
        let options = VisionFaceDetectorOptions()
        options.performanceMode = .accurate
        options.landmarkMode = .all
        options.classificationMode = .all
        let faceDetector = vision.faceDetector(options: options)
        let visionImage = VisionImage(image: image)
        faceDetector.process(visionImage) { faces, error in
            guard error == nil, let faces = faces, !faces.isEmpty else {
                // ...
                return
            }
            
            for face in faces {
                
                let smile = face.smilingProbability
                if(smile > 0.5){
                    self.face_Textview.text += "Smiling: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "True"
                    self.face_Textview.text += "\n"
                }else{
                    self.face_Textview.text += "Smiling: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "False"
                    self.face_Textview.text += "\n"
                }
                
                
                let leftEyeOpen =   face.leftEyeOpenProbability
                if(leftEyeOpen > 0.5){
                    self.face_Textview.text += "Left Eye Open: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "True"
                    self.face_Textview.text += "\n"
                }else{
                    self.face_Textview.text += "Left Eye Open: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "False"
                    self.face_Textview.text += "\n"
                }
                
                let rightEyeOpen =   face.rightEyeOpenProbability
                if(rightEyeOpen > 0.5){
                    self.face_Textview.text += "Right Eye Open: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "True"
                    self.face_Textview.text += "\n"
                }else{
                    self.face_Textview.text += "Right Eye Open: "
                    self.face_Textview.text += "\t"
                    self.face_Textview.text += "False"
                    self.face_Textview.text += "\n"
                }
            }
            
        }
    }
    

    @IBAction func btn_Faceidentify(_ sender: Any) {
        if(image_View.image != nil){
            runFaceRecognization(with: image_View.image!)
        }
        
    }
    
    @IBAction func btn_next(_ sender: Any) {
       image_View.image = UIImage(named: "wink.jpg")
//        if(face_Textview.text != nil){
//            face_Textview.text = ""
//        }
        face_Textview.text = ""
        runFaceRecognizationSecondFace(with: UIImage(named: "wink.jpg")!)
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
