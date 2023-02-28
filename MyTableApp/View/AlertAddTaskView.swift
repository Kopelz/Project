//
//  AlertAddTaskView.swift
//  MyTableApp
//
//  Created by Nikita Gavrilov on 22.02.2023.
//

import UIKit

class AlertAddTaskView: UIView {
    
    private let picker = UIPickerView()

    private let alert: UIAlertController = {
        let alert = UIAlertController()
        
        alert.addTextField { textfield in
            textfield.placeholder = "Input text task"
            textfield.addTarget(AlertAddTaskView.self, action: #selector(callPicker), for: .touchUpInside)
        }
        
        alert.addTextField { textfield in
            textfield.placeholder = "Chose day"
        }
        
        return alert
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPicker() {
        picker.dataSource = self
        picker.delegate = self

    }
    
    
    public func presentAlert() {
        
    }
    
    @objc func callPicker() {
        addSubview(picker)
    }
    
}


extension AlertAddTaskView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0: return "Monday"
        case 1: return "Tuesday"
        case 2: return "Wednesday"
        case 3: return "Thursday"
        case 4: return "Friday"
        case 5: return "Saturday"
        case 6: return "Sunday"
        default: return nil
        }
    }
}

extension AlertAddTaskView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
