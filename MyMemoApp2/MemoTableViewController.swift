//
//  MemoTableViewController.swift
//  MyMemoApp2
//
//  Created by Fumiya.N on 2020/05/07.
//  Copyright © 2020 Fumiya.N. All rights reserved.
//

import UIKit

class MemoTableViewController: UITableViewController {

//    UserDefaults 設定項目等を保存するクラス
    let userDefaults = UserDefaults.standard
    
    var memos = [String]()
    
//    var memos=[
//       "blue","red","pink"
//    ]
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue){
        guard let sourceVC = sender.source as? MemoViewController, let memo =  sourceVC.memo else{
            return
        }
        if let selectedIndexPath=self.tableView.indexPathForSelectedRow{
            self.memos[selectedIndexPath.row]=memo
        }else{
            self.memos.append(memo)
        }
        self.userDefaults.set(self.memos, forKey: "memos")
//        self.memos.append(memo)
        self.tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.userDefaults.object(forKey: "memos") != nil{
            self.memos = self.userDefaults.stringArray(forKey: "memos")!
        }else{
            self.memos=["welcome to selvy!"]
        }
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    //テーブルがいくつ別れているかを設定する
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //メモがいくつあるか設定→メモの数だけあれば良いので、memos.countでok
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memos.count
    }

//    セルを作って、それを返すメソッド
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)

        // Configure the cell...
//        何を表示するか？
        cell.textLabel?.text=self.memos[indexPath.row]
        cell.detailTextLabel?.text=self.memos[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section-\(section)"
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.memos.remove(at: indexPath.row)
            self.userDefaults.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else{
            return
        }
        if identifier == "editMemo"{
            let memoVC = segue.destination as! MemoViewController
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
            
            
        }
        
    }


}
