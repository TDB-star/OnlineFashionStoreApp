//
//  PickerView.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import UIKit

class MyPickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerData : [String]!
    var pickerTextField : UITextField!
    var textFieldValue: String?
   
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)
 
        self.pickerData = pickerData
        pickerTextField = dropdownField
        
        self.delegate = self
        self.dataSource = self
 
        DispatchQueue.main.async {
            if pickerData.count == 1 {
                self.pickerTextField.text = pickerData[0]
                self.pickerTextField.isEnabled = true
            } else if pickerData.count > 0 {
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldValue = pickerData[row]
        pickerTextField.text = textFieldValue
        
        print(textFieldValue ?? "")
        pickerTextField.endEditing(true)
    }
}
