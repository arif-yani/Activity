//
//  addActivityViewController.swift
//  activityApp
//
//  Created by Muhamad Arif on 08/04/22.
//

import UIKit


class addActivityViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var timeCalenderStart: UIDatePicker!
    @IBOutlet weak var timeCalenderEnd: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var desc: UITextField!
    var update: (() -> Void)?
    public var completionHandler: ((String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        field.becomeFirstResponder()
        desc.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveActivity))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCalenderNotificationStart(_ sender: Any) {
        //2A
        let content = UNMutableNotificationContent()
        content.title = "We move to next Level"
        content.sound = .default
        content.body = "Enjoy your activity"
        
        //2B
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: timeCalenderStart.date), repeats: false)
        
        //2C
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        
        //2D
        UNUserNotificationCenter.current().add(request)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveActivity()
        return true
    }
    
    @IBAction func addCalenderNotificationEnd(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Time's Up"
        content.sound = .default
        content.body = "Lets Do Next Activity"
        
        //2B
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: timeCalenderStart.date), repeats: false)
        
        //2C
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        
        //2D
        UNUserNotificationCenter.current().add(request)
    }
    @objc func saveActivity() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
//        if let text = field.text, !text.isEmpty {
//            let pickedDatetimme = timeCalenderEnd.date
//            completionHandler?(text, pickedDatetimme)
//            //kemungkinan gagal
//            navigationController?.popViewController(animated: true)
//        }
//        if let text = field.text, !field.isEmpty,
//           let bodyText = desc.text, !desc.isEmpty {
//
//            completion?(text, bodyText)
//        }
    
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "activity_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)

    }
    

}
