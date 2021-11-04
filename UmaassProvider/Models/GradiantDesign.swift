//
//  GradiantDesign.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var FirstColor : UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
        layer.locations = [ 0.4 ]
    }
}

