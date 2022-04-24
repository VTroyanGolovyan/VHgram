//
//  ChatTableViewCell.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ChatTableViewCell: RoundedCellWithShadow {
    
    static let reuseId = "ChatTableViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastMsg: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var newMsg: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var imgageUrl = ""
    var dialog = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell(chat: Dictionary<String, String>) {
        name.text = chat["dialog_name"]
        lastMsg.text = chat["last_msg"]
        newMsg.text = chat["unread"] ?? "0"
        imgageUrl = chat["dialog_img"] ?? ""
        date.text = ""
        dialog = chat["dialog_table"] ?? ""
        NetworkLayer.loadImage(relativePath: imgageUrl, img: self.img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.img.layer.cornerRadius = self.img.frame.size.width / 2
        self.img.layer.masksToBounds = true
        self.newMsg.layer.cornerRadius = 5
        self.newMsg.layer.masksToBounds = true
    }
}
