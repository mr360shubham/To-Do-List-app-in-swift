//
//  TaskViewController.swift
//  ToDoListApp
//
//  Created by Shubham Baliyan on 26/06/23.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label : UILabel!
    var task : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
        
    }
    
    @objc func deleteTask(){
        guard let task = task else {
                return
            }

            // Remove task from UserDefaults
            if let count = UserDefaults().value(forKey: "count") as? Int {
                for index in 1...count {
                    if let savedTask = UserDefaults().value(forKey: "task\(index)") as? String, savedTask == task {
                        UserDefaults().removeObject(forKey: "task\(index)")
                        break
                    }
                }
                

                // Update the count in UserDefaults
                UserDefaults().set(count - 1, forKey: "count")
               
            }
            
            // Perform any additional cleanup or update tasks if needed
            
            navigationController?.popViewController(animated: true)
        
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
