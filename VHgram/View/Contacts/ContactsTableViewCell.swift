//
//  ChatTableViewCell.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    static let reuseId = "ContactsTableViewCell"
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var id = -1;
    
    @IBAction func newDialogBtn(_ sender: Any) {
        
    }
    
    @IBAction func addContact(_ sender: Any) {
        addButton.setTitle("Remove", for: .normal)
    }
    
    var imgageUrl = ""
    
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
        status.text = contact["status"] == "0" ? "" : contact["status"]
        imgageUrl = contact["avatar"] ?? ""
        online.text = contact["online"] == "0" ? "Offline" : "Online"
        self.img.image = UIImage(named: "profile-user")
        NetworkLayer.loadImage(relativePath: imgageUrl, img: self.img)
    }
    
    override func layoutSubviews() {
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
