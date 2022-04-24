//
//  ChatTableViewCell.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ContactsTableViewCell: RoundedCellWithShadow {

    static let reuseId = "ContactsTableViewCell"
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func newDialogBtn(_ sender: Any) {
        
    }
    
    @IBAction func addContact(_ sender: Any) {
        addButton.setTitle("Remove", for: .normal)
    }
    
    var id = -1;
    var imgageUrl = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        self.img.layer.cornerRadius = self.img.frame.size.width / 2
        self.img.layer.masksToBounds = true
    }
}
