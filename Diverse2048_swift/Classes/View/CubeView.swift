//
//  CubeView.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/16.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit

class CubeView: UIView {
    
    let colors = [UIColor.flatYellowColor(),
                  UIColor.flatYellowColorDark(),
                  UIColor.flatOrangeColor(),
                  UIColor.flatOrangeColorDark(),
                  UIColor.flatRedColorDark(),
                  UIColor.flatRedColor(),
                  UIColor.flatWatermelonColorDark(),
                  UIColor.flatWatermelonColor(),
                  UIColor.flatPinkColorDark(),
                  UIColor.flatPinkColor()]
    
    var text = "" {
        didSet {
            label.text = text
        }
    }
    var textColor = UIColor.flatYellowColor() {
        didSet {
            label.textColor = textColor
        }
    }
    private let label = UILabel()

    override func drawRect(rect: CGRect) {
        addSubview(label)
        label.textAlignment = .Center
        label.textColor = UIColor.flatWhiteColor()
        label.font = UIFont.systemFontOfSize(21)
        label.snp_makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
    }


}
