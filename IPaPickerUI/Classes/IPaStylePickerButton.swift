//
//  IPaStylePickerButton.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/9/24.
//

import UIKit
import IPaDesignableUI
open class IPaBottomTextPickerButton: IPaPickerButton,IPaBottomTextStyle {
    @IBInspectable open var centerSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    public override func reloadStyle() {
        self.assignStyle()
    }
    

}
open class IPaImageRightPickerButton: IPaPickerButton,IPaImageRightStyle {
    @IBInspectable open var centerSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    @IBInspectable open var leftSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    @IBInspectable open var rightSpace: CGFloat = 0 {
        didSet {
            self.assignStyle()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public override func reloadStyle() {
        self.assignStyle()
    }
}
