//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Shubham Baliyan on 26/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        // Do any additional setup after loading the view.
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
        
    }
    
    func updateTasks(){
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task\(x+1)") as? String{
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

    extension ViewController : UITableViewDelegate{
        
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
           
            
            let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
            vc.title = "New Task"
            vc.task = tasks[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    extension ViewController : UITableViewDataSource{
    
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasks.count
        }
    
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = tasks[indexPath.row]
            return cell
        }
    }
    
