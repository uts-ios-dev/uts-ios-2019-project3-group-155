//
//  Line.swift
//  Forex Wallet
//
//  Created by Aruna Sairam Manjunatha on 29/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//

import UIKit

class Line: UIView {

    var line = UIBezierPath()
    func graph(){
        line.move(to: .init(x:0, y:bounds.height/2))
        line.addLine(to: .init(x: bounds.width, y:bounds.height/2))
        UIColor.red.setStroke()
        line.lineWidth = 2
        line.stroke()
    }

}
