//
//  MovieTableViewController.swift
//  Filming Life
//
//  Created by 林郁琦 on 2024/5/18.
//

import UIKit
// 導入Kingfisher框架，用於下載和快取圖片
import Kingfisher

class MovieTableViewController: UITableViewController {
    
    var filmArray = [Fields]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchItem()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let film = filmArray[indexPath.row]
        cell.movieTitleLabel.text = film.movieTitle
        cell.jobTitleLabel.text = film.jobTitle
        cell.movieImage?.kf.setImage(with: film.moviePosteImageName.first?.thumbnails.full.url)
        return cell
    }
    
    @IBSegueAction func toInfoViewController(_ coder: NSCoder, sender: UIButton) -> InfoViewController? {
        // 獲取按鈕在表格視圖中的位置
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        // 獲取按鈕所在行的索引路徑
        guard let indexPath = tableView.indexPathForRow(at: buttonPosition) else { return nil }
        let controller =  InfoViewController(coder: coder)
        // 從filmArray中獲取對應索引位置的電影資訊
        let film = filmArray[indexPath.row]
        controller?.filmInfo = FilmInfo(movieImage: film.moviePosteImageName.first?.thumbnails.full.url, movieTitle: film.movieTitle, movieTime: film.movieTime,infoName: film.infoName )
        return controller
    }
    
    @IBSegueAction func toTrailerViewController(_ coder: NSCoder, sender: UIButton) -> TrailerViewController? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: buttonPosition) else { return nil }
        let controller = TrailerViewController(coder: coder)
        // 將對應行的電影預告資料設置給TrailerViewController。
        controller?.film = filmArray[indexPath.row]
        return controller
    }
    // 定義一個名為fetchItem的方法，用於從API獲取數據
    func fetchItem() {
        let baseData = "https://api.airtable.com/v0/appJLvH9RHhL7jJo7/Projects"
        // 排序參數，按電影時間降序排序
        let sortParameter = "?sort[3][field]=MovieTime&sort[3][direction]=desc"
        let urlString = baseData + sortParameter
        guard let url = URL(string: urlString) else {
            print("無效網址")
            return
        }
        var request = URLRequest(url: url)
        // 設置Airtable API key
        request.setValue("Bearer patvPeQ8NxJyW8vnH.2d2042b4a997f963f8a6037493451b8277dffc37fe2d83ad510337593c2b3b1f", forHTTPHeaderField: "Authorization")
        // 創建URLSessionDataTask，從API獲取數據
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("無數據", error)
                return
            }
            // 創建JSONDecoder，解析從API返回的JSON數據
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    // 轉換成定義的FilmResponse
                    let filmResponse = try decoder.decode(FilmResponse.self, from: data)
                    // FilmResponse中的記錄轉換到定義的filmArray裡面的Fields
                    self.filmArray = filmResponse.records.map { $0.fields }
                    print("成功獲取數據:", self.filmArray)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let response = response {
                print("Failed response: \(response)")
            }
        }.resume()
    }
    // MARK: - Table view data source
}


