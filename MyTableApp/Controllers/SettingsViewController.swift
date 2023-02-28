//
//  SettingsViewController.swift
//  MyTableApp
//
//  Created by Nikita Gavrilov on 22.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        self.view = SettingsView(frame: UIScreen.main.bounds)
    }

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateVC()
    }

    
    // MARK: Configurate Navigation and TabBar
    func configurateVC() {
        view.backgroundColor = .systemBackground
        
        // Navigation
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // TabBarItem
        tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        tabBarController?.tabBar.backgroundColor = .systemBackground
    }
    
}
