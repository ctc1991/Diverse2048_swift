//
//  ViewController.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/12.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var game = Game()
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        game.initGame()
//        game.randomCube()
//        game.randomCube()
//        show()
//        
//        
//        let btn = UIButton()
//        btn.setTitle("重新开始", forState: .Normal)
//        btn.backgroundColor = UIColor.redColor()
//        btn.addTarget(self, action: #selector(action), forControlEvents: .TouchUpInside)
//        view.addSubview(btn)
//        btn.frame = CGRect(x: 30, y: 30, width: 50, height: 50)
//        
//        
//        textView.frame = CGRect(x: 0, y: 0, width: 320, height: 290)
//        textView.center = view.center
//        textView.font = UIFont.systemFontOfSize(32)
//        textView.backgroundColor = UIColor.blackColor()
//        textView.textColor = UIColor.greenColor()
//        textView.userInteractionEnabled = false
//        view.addSubview(textView)
//        
//        createSwipeGestureRecognizer()
    }
    
    func action() {

        GameManager.save(game: game, type: .Default)
        show()
    }
    
    /**
     添加手势
     */
    func createSwipeGestureRecognizer() {
        let swpieForBackgroundUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundUp.direction = .Up
        view.addGestureRecognizer(swpieForBackgroundUp)
        
        let swpieForBackgroundLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundLeft.direction = .Left
        view.addGestureRecognizer(swpieForBackgroundLeft)
        
        let swpieForBackgroundDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundDown.direction = .Down
        view.addGestureRecognizer(swpieForBackgroundDown)
        
        let swpieForBackgroundRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundRight.direction = .Right
        view.addGestureRecognizer(swpieForBackgroundRight)
    }
    
    /**
     手势方法
     
     - parameter sender: 手势对象
     */
    func swipeAction(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.Up:
            if !game.cannotMove(direction: .Up) {
                game.swipe(direction: .Up)
                game.randomCube()
            }
        case UISwipeGestureRecognizerDirection.Left:
            if !game.cannotMove(direction: .Left) {
                game.swipe(direction: .Left)
                game.randomCube()
            }
        case UISwipeGestureRecognizerDirection.Down:
            if !game.cannotMove(direction: .Down) {
                game.swipe(direction: .Down)
                game.randomCube()
            }
        case UISwipeGestureRecognizerDirection.Right:
            if !game.cannotMove(direction: .Right) {
                game.swipe(direction: .Right)
                game.randomCube()
            }
        default:
            break
        }
        

        
        
        
        
        show()
    }
    
    func show() {
        var str = ""
        for cell in game.cells {
            str = str.stringByAppendingString(String(format: "  %d\t\t", cell.score))
            if cell.index!%4 == 3 {
                str = str.stringByAppendingString("\n")
            }
        }
        textView.text = str
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

