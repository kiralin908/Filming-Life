//
//  TrailerViewController.swift
//  Filming Life
//
//  Created by 林郁琦 on 2024/5/28.
//

import UIKit
// 導入WebKit框架，用於顯示和操作web內容
import WebKit

class TrailerViewController: UIViewController {
    // 定義IBOutlet變數，用於顯示網頁內容的 WKWebView
    @IBOutlet weak var trailerVideo: WKWebView!
    
    var film: Fields?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // 覆寫viewWillAppear方法，當視圖將要出現時使用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 如果film的trailerURLName屬性存在值，且能成功轉換為URL
        if let trailerVideoUrl = film?.trailerURLName, let url = URL(string: trailerVideoUrl) {
            let request = URLRequest(url: url)
            trailerVideo.load(request)
        } else {
            print("找不到URL")
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        guard let navigationController = navigationController else { return }
        // 獲取navigationController的viewControllers數量
        let count = navigationController.viewControllers.count
        // 獲取navigationController中倒數第二個的ViewController
        let TrailerViewController = navigationController.viewControllers[count - 2]
        // 返回到指定的ViewController
        navigationController.popToViewController(TrailerViewController, animated: true)
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



