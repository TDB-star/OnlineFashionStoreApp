//
//  ExtentionTextField.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import UIKit

extension UITextField {
    
    func loadDropdownData(data: [String]) {
        inputView = MyPickerView(pickerData: data, dropdownField: self)
    }
    
    func setLeftView(image: String) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = UIImage(systemName: image)
        iconView.tintColor = .lightGray
        iconView.contentMode = .scaleAspectFit
       
          
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        iconContainerView.addSubview(iconView)
        leftViewMode = .always
        leftView = iconContainerView
    }
    
    func setRightView(image: String) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = UIImage(systemName: image)
        iconView.tintColor = .lightGray
        iconView.contentMode = .scaleAspectFit
       
          
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        iconContainerView.addSubview(iconView)
        rightViewMode = .always
        rightView = iconContainerView
    }
}
