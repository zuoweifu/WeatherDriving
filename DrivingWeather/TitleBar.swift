//
//  TitleBar.swift
//  DrivingWeather
//
//  Created by Alex St George on 2018-01-26.
//  Copyright © 2018 Pelmorex Media Inc. All rights reserved.
//

import Foundation
import UIKit

class TitleBar: UIView {
    let title: UILabel!
    
    override init(frame: CGRect) {
        title = UILabel(frame: CGRect(x: 0, y: frame.height/4, width: frame.width, height: frame.height*3/4))
        title.text = "Super Awesome and Useful App"
        title.textAlignment = .center
        title.textColor = UIColor(red: 72/255.0, green: 137/255.0, blue: 199/255.0, alpha: 1)
        title.font = UIFont(name: Constants.FontName, size: 24)
        super.init(frame: frame)
        
        self.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
