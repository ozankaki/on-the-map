//
//  FacebookButton.swift
//  On the Map
//
//  Created by Ozan Kaki on 6.04.2021.
//

import UIKit

class FacebookButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.facebook
        let titlesize = (titleLabel?.frame.size.width)!
        let frameSize = frame.size.width
        let imageSize = (imageView?.frame.size.width)!
        let space = frameSize - titlesize - (imageSize * 2) - 20
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -space, bottom: 0, right: 0 );
    }

}
