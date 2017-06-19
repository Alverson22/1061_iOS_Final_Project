//
//  AccountDetailViewController.swift
//  FinalProject
//
//  Created by user_18 on 2017/6/17.
//  Copyright © 2017年 com.alverson_22. All rights reserved.
//

import UIKit

class AccountDetailViewController: UIViewController {
    
    var accountDic : [String : String]!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conceptTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(accountDic["photo"]!)
        navigationItem.title = accountDic["product"]
        productImage.image = UIImage(contentsOfFile: url!.path)
        paidLabel.text = "$" + accountDic["paid"]!
        dateLabel.text = accountDic["date"]
        conceptTextView.text = accountDic["concept"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
