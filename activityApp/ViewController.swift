//
//  ViewController.swift
//  activityApp
//
//  Created by Muhamad Arif on 08/04/22.
//

import UIKit

struct activityCardList {
    var title:String
    var timeStart:String
    var timeEnd:String
    var desc:String
    var reminder:String
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var activityList = [activityCardList]()
    var activitys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Activity"
        
        //Get all current saved activitys
        let activity1 = activityCardList(title: "Olahraga", timeStart: "07:00", timeEnd: "08:00", desc: "Nothing", reminder: "5 Min Before")
        let activity2 = activityCardList(title: "Baca Buku", timeStart: "08:00", timeEnd: "09:00", desc: "Nothing", reminder: "5 Min Before")
        let activity3 = activityCardList(title: "Academy", timeStart: "09:00", timeEnd: "13:00", desc: "Nothing", reminder: "5 Min Before")
        activityList = [activity1, activity2, activity3]
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateActivitys()
    }
    
    func updateActivitys() {
        
//        activitys.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            activitys.removeAll()
            if let activity = UserDefaults().value(forKey: "activity_\(x+1)") as? String {
                activitys.append(activity)
            }
        }
        tableView.reloadData()
        
        
    }
    
    
    @IBAction func didTapAdd(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        let vc = storyboard?.instantiateViewController(identifier: "add") as! addActivityViewController
        vc.title = "New Activity"
        vc.update = {
            DispatchQueue.main.async {
                self.updateActivitys()
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showAddActivity", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "activity") as! activityViewController
        vc.title = "New Activity"
        vc.activity = activitys[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = activitys[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = heroList[indexPath.row]
//        cell.contentConfiguration = content
//        let activity = activityList[indexPath.row]
//        content.text = activity.title
//        content.secondaryText = "\(activity.timeStart) - \(activity.timeEnd)"
//        cell.contentConfiguration = content
//
//        print(indexPath.row, indexPath.section)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView:UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            activitys.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }

}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("you tapped me")
//    }
//}
//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return day.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        cell.textLabel?.text = day[indexPath.row]
//        return cell
//    }
//}

