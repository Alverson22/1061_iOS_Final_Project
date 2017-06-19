//
//  AccountTableViewController.swift
//  FinalProject
//
//  Created by user_18 on 2017/6/16.
//  Copyright © 2017年 com.alverson_22. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {
    
    var paidList:[[String:String]] = []
    
    var isAdd = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("isADD")
        if isAdd{
            isAdd = false
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func getAddProductNoti(noti:Notification) {
        let m_paidList = noti.userInfo as? [String:String]
        
        paidList.insert(m_paidList!, at: 0)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("paidList.txt")
        (paidList as NSArray).write(to: url!, atomically: true)
        
        isAdd = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("paidList.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            paidList = array as! [[String:String]]
        }
        
        let notiName = Notification.Name("AddPaidList")
        NotificationCenter.default.addObserver(self, selector: #selector(AccountTableViewController.getAddProductNoti(noti:)), name: notiName, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paidList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountTableViewCell

        // Configure the cell...
        let dic = paidList[indexPath.row]
        
        cell.dateLabel?.text = dic["date"]
        cell.productLabel?.text = dic["product"]
        cell.paidLabel?.text = "$" + dic["paid"]!
        
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

        // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        paidList.remove(at: indexPath.row)
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("paidList.txt")
        print(url)
        (paidList as NSArray).write(to: url!, atomically: true)
        tableView.reloadData()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dic:[String:String]
            dic = paidList[indexPath!.row]
            
            
            let controller = segue.destination as!
            AccountDetailViewController
            controller.accountDic = dic
        }
        
    }

}
