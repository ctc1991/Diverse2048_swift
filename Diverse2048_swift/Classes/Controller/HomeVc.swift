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
    let bgIv = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        bgIv.image = UIImage(named: "bg")
        bgIv.frame = view.bounds
        bgIv.contentMode = .ScaleAspectFill
        view.addSubview(bgIv)
        
        let xEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xEffect.minimumRelativeValue = -20
        xEffect.maximumRelativeValue =  20
        bgIv.addMotionEffect(xEffect)
        
        // 开始按钮
        startBtn.titleLabel?.font = UIFont(name: "Tensentype-BoDangXingKaiF", size: 32)
        startBtn.setTitle("开始游戏", forState: .Normal)
        startBtn.setTitleColor(UIColor.flatBlackColor(), forState: .Normal)
        startBtn.setTitleColor(UIColor.flatGrayColorDark(), forState: .Highlighted)
        startBtn.addTarget(self, action: #selector(gotoGameVc), forControlEvents: .TouchUpInside)
        view.addSubview(startBtn)
        startBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(view.frame.width*0.4, view.frame.width*0.4/205*68))
//            make.bottom.equalTo(view.snp_centerY).offset(-10)
            make.centerY.equalTo(view)
            make.centerX.equalTo(view)
        }
//        // 排行榜按钮
//        rankBtn.titleLabel?.font = UIFont(name: "Tensentype-BoDangXingKaiF", size: 32)
//        rankBtn.setTitle("封神の榜", forState: .Normal)
//        rankBtn.setTitleColor(UIColor.flatBlackColor(), forState: .Normal)
//        rankBtn.setTitleColor(UIColor.flatGrayColorDark(), forState: .Highlighted)
//        view.addSubview(rankBtn)
//        rankBtn.snp_makeConstraints { (make) in
//            make.top.equalTo(view.snp_centerY).offset(10)
//            make.size.equalTo(startBtn)
//            make.centerX.equalTo(startBtn)
//        }
//        // 设置按钮
//        settingBtn.titleLabel?.font = UIFont(name: "Tensentype-BoDangXingKaiF", size: 32)
//        settingBtn.setTitle("设置", forState: .Normal)
//        settingBtn.setTitleColor(UIColor.flatBlackColor(), forState: .Normal)
//        settingBtn.setTitleColor(UIColor.flatGrayColorDark(), forState: .Highlighted)
//        settingBtn.addTarget(self, action: #selector(gotoSetting), forControlEvents: .TouchUpInside)
//        view.addSubview(settingBtn)
//        settingBtn.snp_makeConstraints { (make) in
//            make.centerX.equalTo(startBtn)
//            make.top.equalTo(rankBtn.snp_bottom).offset(20)
//        }
    }
    
    func gotoGameVc() {
        soundManager.play(sound: soundManager.moveSound!)
        presentViewController( GameVc(), animated: true, completion: nil)
    }

    func gotoSetting() {
        presentViewController( SettingVc(), animated: true, completion: nil)
    }
    
}
