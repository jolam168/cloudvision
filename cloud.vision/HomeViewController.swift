//
//  HomeViewController.swift
//  cloud.vision
//
//

import UIKit

class HomeViewController: UIViewController {

	var bottomSheetVC = BottomSheetViewController()
	@IBOutlet weak var showSheetButton: UIButton!
	override func viewDidLoad() {
        super.viewDidLoad()
		addBottomSheetView()
        // Do any additional setup after loading the view.
    }
    
	func addBottomSheetView(scrollable: Bool? = true){
		
		
		self.addChild(bottomSheetVC)
		self.view.addSubview(bottomSheetVC.view)
		bottomSheetVC.didMove(toParent: self)
		
		let height = view.frame.height
		let width  = view.frame.width
		bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
	}
	
	@IBAction func showSheet(_ sender: Any) {
		bottomSheetVC.show()
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
