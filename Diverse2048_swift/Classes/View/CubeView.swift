//
//  CubeView.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/16.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit

class CubeView: UIView {
    

    
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
        label.font = UIFont(name: "42", size: 21)
        label.snp_removeConstraints()
        label.snp_makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
    }


}
