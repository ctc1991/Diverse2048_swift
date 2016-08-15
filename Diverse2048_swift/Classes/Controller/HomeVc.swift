//
//  HomeVc.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/16.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit

class HomeVc: ViewController {
    
    let startBtn = UIButton()
    let rankBtn = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "img_blueSky")!)
        startBtn.setImage(UIImage(named: "btn_start_normal"), forState: .Normal)
        startBtn.setImage(UIImage(named: "btn_start_highLight"), forState: .Highlighted)
        view.addSubview(startBtn)
        startBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(view.frame.width/3, view.frame.width/3/(205/68)))
            make.center.equalTo(view)
        }
        
        rankBtn.setImage(UIImage(named: "btn_rank_normal"), forState: .Normal)
        rankBtn.setImage(UIImage(named: "btn_rank_highLight"), forState: .Highlighted)
        view.addSubview(rankBtn)
        rankBtn.snp_makeConstraints { (make) in
            make.size.equalTo(startBtn)
            make.centerX.equalTo(startBtn)
            make.top.equalTo(startBtn.snp_bottom).offset(12)
        }
    }

}
