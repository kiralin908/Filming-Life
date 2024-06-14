//
//  InfoViewController.swift
//  Filming Life
//
//  Created by 林郁琦 on 2024/5/26.
//

import UIKit
import Kingfisher
// 定義FilmInfo結構，用於儲存電影相關資訊
struct FilmInfo {
    var movieImage: URL?
    var movieTitle: String
    var movieTime: String
    var infoName: String?
}

class InfoViewController: UIViewController {
    // 定義IBOutlet變數，把需要設定到的UI元件拉outlet
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTimeLabel: UILabel!
    @IBOutlet weak var movieInfo: UITextView!
    
    var filmInfo: FilmInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        movieTitleLabel.text? = filmInfo.movieTitle
        movieTimeLabel.text? = filmInfo.movieTime
        movieInfo.text = filmInfo.infoName
        // 如果filmInfo的movieImage屬性存在值，使用Kingfisher框架下載並設置電影圖片
        if let imageUrl = filmInfo.movieImage{
            movieImage.kf.setImage(with: imageUrl)
        }
    }
    
    @IBAction func closeController(_ sender: UIButton) {
        guard let navigationController = navigationController else { return }
        let count = navigationController.viewControllers.count
        let MovieTableViewController = navigationController.viewControllers[count - 2]
        navigationController.popToViewController(MovieTableViewController, animated: true)
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
