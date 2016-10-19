//
//  RandomAuthCodeSwift.swift
//  RandomAuthCode-Swift
//
//  Created by 爱利是 on 16/10/19.
//  Copyright © 2016年 haohao. All rights reserved.
//

import UIKit

let CODECOUNT = 4
typealias SendCodeMessageClosure = (_ codeTextStr : String) -> Void

class RandomAuthCodeSwift: UIView {

    //默认的数组
    private lazy var codeMessageArray = { () -> [String] in
        let codeMessageArray = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        return codeMessageArray
    }()
    
    var codeString = String()
    var sendCodeMessageClosure : SendCodeMessageClosure?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setRandomAuthCodeViewBackGroundColor()
        self.setRandomAuthCodeMessage()
        self.setTapGestureToModifyCodeMessage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setRandomAuthCodeViewBackGroundColor()
        self.setRandomAuthCodeMessage()
        self.setTapGestureToModifyCodeMessage()
    }
    
    class func sharedRandomAuthCodeViewWithFrame(frame : CGRect) -> RandomAuthCodeSwift {
        return RandomAuthCodeSwift.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setRandomAuthCodeViewBackGroundColor()
        self.setRandomAuthCodeMessage()
        self.setTapGestureToModifyCodeMessage()
    }
    
//MARK: ------ 设置界面背景色
    private func setRandomAuthCodeViewBackGroundColor() {
        let hue = CGFloat(arc4random() % 360)
        let color = UIColor.init(hue: 1.0 * hue / 360.0, saturation: 1.0, brightness: 1.0, alpha: 0.5)
        self.backgroundColor = color
    }
    
//MARK: ------ 设置验证码信息
    private func setRandomAuthCodeMessage() {
        self.showCodeMessage()
    }
    
//MARk ------- 添加手势
    private func setTapGestureToModifyCodeMessage() {
        let tap = UITapGestureRecognizer.init(target: self
            , action: #selector(RandomAuthCodeSwift.tapSelector(tap:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }

    @objc private func tapSelector(tap : UITapGestureRecognizer) {
        self.setRandomAuthCodeViewBackGroundColor()
        self.showCodeMessage()
        //开始绘图
        self.setNeedsDisplay()
    }
    
    private func showCodeMessage() {
        codeString = ""
        for _ in 0..<CODECOUNT {
            let str = codeMessageArray[Int(arc4random() % UInt32((codeMessageArray.count - 1)))]
            codeString = codeString + str
        }
        if self.sendCodeMessageClosure != nil {
            self.sendCodeMessageClosure!(codeString)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.sendCodeMessageClosure != nil {
            self.sendCodeMessageClosure!(codeString)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let string = "A"
        let charSize = string.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20)])
        let width = UInt32(rect.size.width / CGFloat(codeString.characters.count) - charSize.width)
        let height = UInt32(rect.size.height - charSize.height)
        var point = CGPoint()
        var pX : CGFloat = 0
        var pY : CGFloat = 0
        for index in 0..<codeString.characters.count {
            pX = CGFloat(arc4random() % width) + rect.size.width / CGFloat(codeString.characters.count) * CGFloat(index)
            pY = CGFloat(arc4random() % height)
            point = CGPoint(x: pX, y: pY)
            let c = codeString[codeString.index(codeString.startIndex, offsetBy: index)]
            let str : NSString = NSString.init(string: "\(c)")
            str.draw(at: point, withAttributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20)])
        }
        //获取当前上下文
        let context = UIGraphicsGetCurrentContext()
        //设置背景线的宽度
        context!.setLineWidth(1.0)
        //绘制8根背景线
        for _ in 0..<8 {
            let hue = CGFloat(arc4random() % 360)
            let color = UIColor.init(hue: 1.0 * hue / 360.0, saturation: 1.0, brightness: 1.0, alpha: 0.5)
            context!.setStrokeColor(color.cgColor)
            pX = CGFloat(arc4random() % UInt32(rect.size.width))
            pY = CGFloat(arc4random() % UInt32(rect.size.height))
            context?.move(to: CGPoint(x: pX, y: pY))
            pX = CGFloat(arc4random() % UInt32(rect.size.width))
            pY = CGFloat(arc4random() % UInt32(rect.size.height))
            context?.addLine(to: CGPoint(x: pX, y: pY))
            context?.strokePath()
        }
        
    }

}
