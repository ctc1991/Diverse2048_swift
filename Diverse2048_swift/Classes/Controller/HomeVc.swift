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
    let settingBtn = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        initUI()

    }
    
    func initUI() {
        // 背景图
        view.backgroundColor = UIColor.init(patternImage: UIImage(named: "img_blueSky")!)
        // 开始按钮
        startBtn.setImage(UIImage(named: "btn_start_normal"), forState: .Normal)
        startBtn.setImage(UIImage(named: "btn_start_highLight"), forState: .Highlighted)
        startBtn.addTarget(self, action: #selector(gotoGameVc), forControlEvents: .TouchUpInside)
        view.addSubview(startBtn)
        startBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(view.frame.width*0.4, view.frame.width*0.4/205*68))
            make.center.equalTo(view)
        }
        // 排行榜按钮
        rankBtn.setImage(UIImage(named: "btn_rank_normal"), forState: .Normal)
        rankBtn.setImage(UIImage(named: "btn_rank_highLight"), forState: .Highlighted)
        view.addSubview(rankBtn)
        rankBtn.snp_makeConstraints { (make) in
            make.size.equalTo(startBtn)
            make.centerX.equalTo(startBtn)
            make.top.equalTo(startBtn.snp_bottom).offset(12)
        }
        // 设置按钮
        settingBtn.setImage(UIImage(named: "btn_setting_normal"), forState: .Normal)
        settingBtn.setImage(UIImage(named: "btn_setting_highLight"), forState: .Highlighted)
        view.addSubview(settingBtn)
        settingBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(startBtn)
            make.bottom.equalTo(view).offset(-12)
        }

    }
    
    func gotoGameVc() {
        presentViewController( GameVc(nibName: "GameVc", bundle: nil), animated: true, completion: nil)
    }

}
