//
//  GameVc.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/16.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit

class GameVc: ViewController, GameDelegate {
    
    var game = Game()

    let scoreLbl = UILabel()
    let highScoreLbl = UILabel()
    let gameView = UIView()
    var cubes = Array<CubeView>()
    let gameIv = UIImageView()
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
        game.delegate = self
        createSwipeGestureRecognizer()
        initGameView()
        updateGameUI()
    }

    
    func initUI() {
        // 背景
        view.backgroundColor = UIColor.whiteColor()
        // 游戏背景框
        gameIv.image = UIImage(named: "game_bg")
        gameIv.contentMode = .ScaleToFill
        view.addSubview(gameIv)
        gameIv.frame = CGRect(x: 16, y: 128, width: view.frame.width-32, height: view.frame.height-128-64)
        // 游戏区域
        view.addSubview(gameView)
        gameView.frame = CGRect(x: 16+22, y: 128+22, width: view.frame.width-32-44, height: view.frame.height-128-64-44)
        // 计分板
        view.addSubview(scoreLbl)
        scoreLbl.font = UIFont(name: "42", size: 40)
        scoreLbl.textAlignment = .Center
        scoreLbl.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(34)
            make.bottom.equalTo(gameIv.snp_top).offset(-24)
            make.left.equalTo(gameIv.snp_left).offset(22)
            make.right.equalTo(gameIv.snp_right).offset(-22)
        }
        // 高分板
        view.addSubview(highScoreLbl)
        highScoreLbl.font = UIFont(name: "42", size: 18)
        highScoreLbl.textAlignment = .Center
        highScoreLbl.snp_makeConstraints { (make) in
            make.top.equalTo(scoreLbl.snp_bottom).offset(0)
            make.bottom.equalTo(gameIv.snp_top).offset(0)
            make.left.equalTo(gameIv.snp_left).offset(22)
            make.right.equalTo(gameIv.snp_right).offset(-22)
        }
        // 首页
        let backBtn = UIButton()
        backBtn.titleLabel?.font = UIFont(name: "Tensentype-BoDangXingKaiF", size: 32)
        backBtn.setTitle("首页", forState: .Normal)
        backBtn.setTitleColor(UIColor.flatBlackColor(), forState: .Normal)
        backBtn.setTitleColor(UIColor.flatGrayColorDark(), forState: .Highlighted)
        backBtn.addTarget(self, action: #selector(backHome), forControlEvents: .TouchUpInside)
        backBtn.titleLabel?.sizeToFit()
        view.addSubview(backBtn)
        backBtn.snp_makeConstraints { (make) in
            make.left.equalTo(gameIv.snp_left).offset(22)
            make.top.equalTo(view).offset(8)
        }
        // 重开
        let restartBtn = UIButton()
        restartBtn.titleLabel?.font = UIFont(name: "Tensentype-BoDangXingKaiF", size: 32)
        restartBtn.setTitle("重开", forState: .Normal)
        restartBtn.setTitleColor(UIColor.flatBlackColor(), forState: .Normal)
        restartBtn.setTitleColor(UIColor.flatGrayColorDark(), forState: .Highlighted)
        restartBtn.addTarget(self, action: #selector(restart), forControlEvents: .TouchUpInside)
        restartBtn.titleLabel?.sizeToFit()
        view.addSubview(restartBtn)
        restartBtn.snp_makeConstraints { (make) in
            make.right.equalTo(gameIv.snp_right).offset(-22)
            make.top.equalTo(view).offset(8)
        }
    }
    
    func initGameView() {
        let spacing = CGFloat(6)
        let cubeWidth = (gameView.frame.width - CGFloat(game.column+1)*spacing)/CGFloat(game.column)
        
        let cubeHeight = (gameView.frame.height - CGFloat(game.row+1)*spacing)/CGFloat(game.row)
        
        for i in 0...(game.column*game.row-1) {
            let x = spacing + CGFloat(i%game.column) * (cubeWidth + spacing);
            let y = spacing + CGFloat(i/game.column) * (cubeHeight + spacing);
            let frame = CGRect(x: x, y: y, width: cubeWidth, height: cubeHeight)
            let cube = CubeView(frame: frame)
            cube.layer.cornerRadius = 8
            cube.layer.masksToBounds = true
            cube.layer.borderWidth = 1.0
            cube.backgroundColor = UIColor.flatSandColor()
            cube.layer.borderColor = UIColor.flatBlackColorDark().CGColor
            gameView.addSubview(cube)
            cubes.append(cube)
        }
    }
    
    func updateGameUI() {
        for index in 0...game.cells.count-1 {
            if game.cells[index].score == 0 {
                cubes[index].text = ""
            } else {
                cubes[index].text = String(format: "%d", game.cells[index].score)
            }
           
            if root(game.cells[index].score) > colorManager.colors.count-1 {
                cubes[index].backgroundColor = colorManager.colors.last
            } else {
                cubes[index].backgroundColor = colorManager.colors[root(game.cells[index].score)]
            }
            
            if game.cells[index].score > 4 {
                cubes[index].textColor = UIColor.flatWhiteColor()
            } else {
                cubes[index].textColor = UIColor.flatBlackColor()
            }
            
            scoreLbl.text = String(game.score)
            if game.score > GameManager.load(type: .Default) {
                GameManager.save(score: game.score, type: .Default)
            }
            highScoreLbl.text = String(GameManager.load(type: .Default))
            
        }
    }
 
    // MARK: 求2的几次幂
    func root(score: Int) -> Int {
        var num = 0
        var s = Int(score)
        while s%2 == 0 && s != 0 {
            num += 1
            s = s/2
        }
        return num
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

    func backHome(sender: UIButton) {
        GameManager.save(game: game, type: .Default)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func restart(sender: UIButton) {
        GameManager.removeAllGames(.Default)
        game.initGame()
        game.randomCube()
        game.randomCube()
        updateGameUI()
        game.delegate = self
    }
    
    // MARK: GameDelegate
    func gameover() {
        print("gameover")
    }

    func gameMerge() {
        soundManager.play(sound: soundManager.mergeSound!)
    }
    
    func gameMove() {
        soundManager.play(sound: soundManager.moveSound!)
    }
}
