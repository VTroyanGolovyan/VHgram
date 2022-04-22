//
//  ChatTableViewCell.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastMsg: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var newMsg: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var imgageUrl = ""
    
    static let reuseId = "ChatTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(chat: Dictionary<String, String>) {
        name.text = chat["dialog_name"]
        lastMsg.text = chat["last_msg"]
        newMsg.text = chat["unread"] ?? "0"
        imgageUrl = chat["dialog_img"] ?? ""
        date.text = ""
        NetworkLayer.loadImage(relativePath: imgageUrl, img: self.img)
    }
    
    override func layoutSubviews() {
        // Set the width of the cell
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.shadowColor =  UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 4
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.img.layer.cornerRadius = self.img.frame.size.width / 2
        self.img.layer.masksToBounds = true
        self.newMsg.layer.cornerRadius = 5
        self.newMsg.layer.masksToBounds = true
    }
}
