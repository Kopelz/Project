//
//  MainViewCell.swift
//  MyTableApp
//
//  Created by Nikita Gavrilov on 22.02.2023.
//

import UIKit
import SnapKit

class MainViewCell: UITableViewCell {

    private let taskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(taskLabel)
        taskLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-8)
        }
    }
    
    public func set(task: Task) {
        taskLabel.text = task.taskText
    }
}

