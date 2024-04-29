//
//  DetailViewController.swift
//  Feeds
//
//  Created by Sruthi CS on 29/04/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var datas : String?
    @IBOutlet weak var idNumber: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let datas = datas {
            idNumber.text = "Description"
            detailTextView.text = datas
               } else {
                   // Handle the case where selected is nil
                   print("Selected is nil")
               }
      
        // Do any additional setup after loading the view.
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
