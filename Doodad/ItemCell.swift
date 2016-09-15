//
//  ItemCell.swift
//  Doodad
//
//  Created by Michael Dunn on 2016-09-14.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(_ item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        itemImage.image = item.toImage?.image as? UIImage
    }
    
}
