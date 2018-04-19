//
//  IPaPickerButton.swift
//  Pods
//
//  Created by IPa Chen on 2018/1/22.
//  Copyright 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc public protocol IPaPickerButtonDelegate {
    func numberOfRow(in button:IPaPickerButton) -> Int
    func pickerButton(_ button:IPaPickerButton,titleForRow row:Int) -> String
    func pickerButton(_ button:IPaPickerButton,didSelectRow row:Int)
    @objc optional func pickerButtonWidth(_ button:IPaPickerButton) -> CGFloat
    @objc optional func rowHightInPickerButton(_ button:IPaPickerButton) -> CGFloat
}

open class IPaPickerButton :UIButton {
    open var delegate:IPaPickerButtonDelegate!
    lazy var pickerView:UIPickerView = {
        var _pickerView = UIPickerView(frame:.zero)
        _pickerView.delegate = self
        _pickerView.dataSource = self
        _pickerView.showsSelectionIndicator = true
        return _pickerView
    }()
    lazy var toolBar:UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .blackTranslucent
        toolBar.autoresizingMask = .flexibleHeight
        toolBar.sizeToFit()
        var frame = toolBar.frame
        frame.size.height = 44
        toolBar.frame = frame;
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(IPaPickerButton.onDone(_:)))
        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let array = [flexibleSpaceLeft,doneBtn]
        toolBar.items = array
        return toolBar
        }()
    override open var inputView:UIView! {
        get {
            return pickerView as UIView
            
        }
    }
    override open var inputAccessoryView:UIView! {
        get {
            return toolBar as UIView
        }
    }
    override open func awakeFromNib() {
        super.awakeFromNib()

    }
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self,
                  action:#selector(IPaPickerButton.onTouch(_:)),
                  for:.touchUpInside)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self,
                  action:#selector(IPaPickerButton.onTouch(_:)),
                  for:.touchUpInside)
    }
    @objc func onTouch(_ sender:Any) {
        becomeFirstResponder()
    }

    @objc func onDone(_ sender:Any) {
        //MARK:insert your onDone code
        resignFirstResponder()
        self.delegate.pickerButton(self, didSelectRow: pickerView.selectedRow(inComponent: 0))
    }
    
}
extension IPaPickerButton :UIPickerViewDelegate,UIPickerViewDataSource
{
    //MARK: UIPickerViewDataSource
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.delegate.numberOfRow(in: self)
    }
    //MARK: UIPickerViewDelegate
    // returns width of column and height of row for each component.

    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        guard let pickerButtonWidth = self.delegate.pickerButtonWidth else {
            return 100
        }
        return pickerButtonWidth(self)
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        guard let rowHightInPickerButton = self.delegate.rowHightInPickerButton else {
            return 44
        }
        return rowHightInPickerButton(self)
    }
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.delegate.pickerButton(self, titleForRow: row)
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.delegate.pickerButton(self, didSelectRow: row)
    }
}