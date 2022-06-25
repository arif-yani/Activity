//
//  activityViewController.swift
//  activityApp
//
//  Created by Muhamad Arif on 10/04/22.
//

import UIKit

class activityViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var activity: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = activity

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editActivity))
    }
    
    @objc func editActivity() {
        
//        let newCount = count - 1
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "activity_\(currentPosition)")
    }
    

}
