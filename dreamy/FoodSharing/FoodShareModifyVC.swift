//
//  FoodShareModifyVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/30.
//

import UIKit

class FoodShareModifyVC: UIViewController {

    @IBOutlet var foodTitle: UITextField!
    @IBOutlet var contents: UITextField!
    
    var foodtitle: String?
    var foodcontents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let foodtitle = foodtitle{
            self.foodTitle.text = foodtitle
//            self.foodTitle.sizeToFit()
        }
        
        if let foodcontents = foodcontents{
            self.contents.text = foodcontents
//            self.contents.sizeToFit()
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func modifyBtn(_ sender: Any) {
        FoodShareModify(title: foodTitle.text!, contents: contents.text!, writingID: foodDetailS.WritingID, town: foodDetailS.Town!){
            
            NotificationCenter.default.post(name: .loadDataNotification, object: nil)
            
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    

}
