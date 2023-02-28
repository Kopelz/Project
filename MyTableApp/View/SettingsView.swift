//
//  SettingsView.swift
//  MyTableApp
//
//  Created by Nikita Gavrilov on 22.02.2023.
//

import UIKit

final class SettingsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(button)
    }
        
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
        }
    }
}
