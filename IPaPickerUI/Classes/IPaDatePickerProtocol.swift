//
//  IPaDatePickerProtocol.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/10/12.
//

import UIKit

protocol IPaDatePickerProtocol:UIView {
    var pickerView:UIDatePicker { get set}
    var toolBar:UIToolbar {get set }
    var toolBarConfirmText:String {get}
    var onPickerConfirm:Selector {get}
    var selectedDate:Date {get set}
    var dateObserver:NSKeyValueObservation? {get set}
    func updateUI()
    func createDefaultPickerView() -> UIDatePicker
    func createDefaultToolBar() -> UIToolbar
    func onSelectedDateUpdated()
}
extension IPaDatePickerProtocol {
    
    func createDefaultPickerView() -> UIDatePicker {
        let pickerView = UIDatePicker(frame:.zero)
        dateObserver = pickerView.observe(\.date, changeHandler: { (datePicker, valueChanged) in
            self.onSelectedDateUpdated()
        })
        return pickerView
    }
    func createDefaultToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .blackTranslucent
        toolBar.autoresizingMask = .flexibleHeight
        toolBar.sizeToFit()
        var frame = toolBar.frame
        frame.size.height = 44
        toolBar.frame = frame;
        let doneBtn = UIBarButtonItem(title: self.toolBarConfirmText, style: .done, target: self, action: onPickerConfirm)
        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let array = [flexibleSpaceLeft,doneBtn]
        toolBar.items = array
        return toolBar
    }
    
}
