//
//  WaterMark.swift
//  Lmx
//
//  Created by Lmx on 2020/5/21.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit

extension UIView {
    /* 添加水印 */
    func addWaterText(degrees:CGFloat, labels:[String],color:UIColor,font:UIFont) {
        let height = UIScreen.main.bounds.size.height
        let width = UIScreen.main.bounds.size.width
        // 水印第几行表示
        var index = 0
        // 水印Y轴起始位置坐标
        var positionY:CGFloat = 0
        // 水印字符串最大宽度
        var textWidth:CGFloat = 50
        
        while positionY <= height {
            index += 1
            // 水印X轴起始位置坐标
            var positionX:CGFloat = -width + CGFloat((index % 2)) * textWidth
            // 每行水印前一个跟后一个Y轴偏移
            var spacingY: CGFloat = 0
            while positionX < width {
                // 每个水印前一个label跟后一个labelY轴偏移
                var spacing: CGFloat = 0
                for i in labels.indices {
                    // 水印第i个label字符串
                    let drawText = labels[i]
                    // 水印第i个字符串CGSize
                    let textSize:CGSize = drawText.sizeWithText(font: font)
                    if textSize.width > textWidth {
                        textWidth = textSize.width
                    }
                    // 添加水印
                    let textLayer = CATextLayer.init()
                    textLayer.contentsScale = UIScreen.main.scale
                    textLayer.font = font
                    textLayer.fontSize = font.pointSize
                    textLayer.foregroundColor = color.cgColor
                    textLayer.string = drawText
                    
                    textLayer.frame = CGRect(x: positionX, y: positionY + spacing + spacingY, width: textSize.width , height: textSize.height)
                    // 旋转水印
                    textLayer.transform = CATransform3DMakeRotation(degrees * CGFloat(Double.pi) / 180, 0, 0, 3)
                    self.layer.addSublayer(textLayer)
                    if i != labels.count - 1 {
                        spacing += textSize.height
                    } else {
                        spacingY += textSize.height
                    }
                }
                // 下一个水印X轴位置
                positionX += textWidth * 2
            }
            // 下一行水印Y轴位置
            positionY += height / 10 + 80
        }
    }
    
    /* 移除水印 */
    func removeTextLayer(water:String)  {
        let layers = self.layer.sublayers
        var sublayers = [CALayer]()
        
        for (idx,layer) in (layers?.enumerated())! {
            
            if layer .isKind(of: CATextLayer.self) {
                let textLayer = layer as!CATextLayer
                
                let waterText:String = textLayer.string as! String
                
                guard water == waterText else {
                    return
                }
                
            }else{
                sublayers.append(layer)
            }
            
            
            print(layer.frame,idx)
        }
        self.layer.sublayers = sublayers
        
        
    }
}
extension String{
    /* 根据文本字体大小获取字符串CGSize */
    func sizeWithText(font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: option, attributes: attributes, context: nil)
        return rect.size;
    }
    
}
