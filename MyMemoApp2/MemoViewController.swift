//
//  MemoViewController.swift
//  MyMemoApp2
//
//  Created by Fumiya.N on 2020/05/08.
//  Copyright © 2020 Fumiya.N. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    var memo: String?
    
    @IBOutlet weak var memoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.saveButton.isEnabled = false
        // Do any additional setup after loading the view.
        
        if let memo = self.memo{
            self.memoTextField.text = memo
            self.navigationItem.title = "Edit Memo"
        }
        self.updateSaveButtonState()
    }
    
    
    private func updateSaveButtonState(){
        let memo = self.memoTextField.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
   
    @IBAction func memoTextFieldChanged(_ sender: Any) {
        self.updateSaveButtonState()
    }
    
    @IBAction func cancel(_ sender: Any) {
        if self.presentingViewController is UINavigationController{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
//            guardは条件に一致なかった場合に、処理を中断させるための構文。save bottun出なかったら処理を止めるためreturn
        }
        self.memo = self.memoTextField.text ?? ""
        
    }
    
}
