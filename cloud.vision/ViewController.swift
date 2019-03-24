//
//  ViewController.swift
//  cloud.vision
//
//
import CoreML
import UIKit

@available(iOS 11.0, *)
class ViewController: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    var imagePicker = UIImagePickerController()
	var model : ImageClassifier!
	
    @IBOutlet weak var imagePicked: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
	
	override func viewWillAppear(_ animated: Bool) {
		model = ImageClassifier()

		
	}

    @IBAction func buttonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
			return
		}

		
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
		
		UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
		image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
		var pixelBuffer : CVPixelBuffer?
		let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
		guard (status == kCVReturnSuccess) else {
			return
		}
	
		
		guard let prediction = try? model.prediction(image: pixelBuffer!) else {
			return
		}
		
		print(prediction.classLabelProbs)
//		classifier.text = "I think this is a \(prediction.classLabel)."
		
    }
}

