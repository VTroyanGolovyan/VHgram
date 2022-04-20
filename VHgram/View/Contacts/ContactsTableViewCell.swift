//
//  ChatTableViewCell.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var imgageUrl = ""
    
    static let reuseId = "ContactsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(contact: Dictionary<String, String>) {
        name.text = contact["name"]! + " " + contact["second_name"]!
        status.text = contact["status"]
        imgageUrl = contact["avatar"] ?? ""

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
    }
}
