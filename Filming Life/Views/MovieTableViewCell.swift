//
//  MovieTableViewCell.swift
//  Filming Life
//
//  Created by 林郁琦 on 2024/5/26.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // 定義IBOutlet變數，把需要設定到的UI元件拉outlet
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
