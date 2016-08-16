//
//  GameVc.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/16.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit

class GameVc: ViewController {
    
    var game = Game()

    @IBOutlet weak var gameView: UIView!
    var cubes = Array<UILabel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        
        if GameManager.load(.Default).count == 0 {
            game.initGame()
            game.randomCube()
            game.randomCube()
        } else {
            game = GameManager.load(.Default).last!
        }
        
        

        
        createSwipeGestureRecognizer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        initGameView()
        updateGameUI()
    }
    
    func initUI() {
        
    }
    
    func initGameView() {
        let spacing = CGFloat(4)
        let cubeWidth = (gameView.frame.width - CGFloat(game.column+1)*spacing)/CGFloat(game.column)
        
        let cubeHeight = (gameView.frame.height - CGFloat(game.row+1)*spacing)/CGFloat(game.row)
        
        for i in 0...(game.column*game.row-1) {
            print(i%game.column)
            let x = CGFloat(4) + CGFloat(i%game.column) * (cubeWidth + CGFloat(4));
            let y = CGFloat(4) + CGFloat(i/game.column) * (cubeHeight + CGFloat(4));
            let frame = CGRect(x: x, y: y, width: cubeWidth, height: cubeHeight)
            let cube = UILabel(frame: frame)
            cube.textAlignment = .Center
            cube.textColor = UIColor.whiteColor()
            cube.layer.cornerRadius = 5.0
            cube.layer.masksToBounds = true
            cube.backgroundColor = UIColor.flatGreenColorDark()
            cube.font = UIFont.systemFontOfSize(18)
            gameView.addSubview(cube)
            cubes.append(cube)
        }
    }
    
    func updateGameUI() {
        for index in 0...game.cells.count-1 {
            cubes[index].text = String(format: "%d", game.cells[index].score)
        }
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
        updateGameUI()
    }

    @IBAction func backHome(sender: UIButton) {
        GameManager.save(game: game, type: .Default)
        dismissViewControllerAnimated(true, completion: nil)
    }

}
