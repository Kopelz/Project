//
//  ViewController.swift
//  MyTableApp
//
//  Created by Nikita Gavrilov on 22.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = Sourse.createGroup() 
    let picker = UIPickerView(frame: .zero)
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        // TextField - task
        alert.addTextField { textfield in
            textfield.placeholder = "Input your task"
        }
        
        // TextField - week
        alert.addTextField { [self] textfield in
            textfield.placeholder = "Input week"
            textfield.inputView = picker
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [unowned self] _ in
            // проверка на nil
            guard let taskText = alert.textFields?[0].text,
                  let week = alert.textFields?[1].text else { return print("error alert") }

            var enumWeek : Week = .Monday
            switch week {
            case ".Monday": enumWeek = .Monday
            case ".Thursday": enumWeek = .Thursday
            case ".Wednesday": enumWeek = .Wednesday
            case ".Tuesday": enumWeek = .Tuesday
            case ".Friday": enumWeek = .Friday
            case ".Saturday": enumWeek = .Saturday
            case ".Sunday": enumWeek = .Sunday
            default: break
            }
            
            let result: [Task] = [.init(taskText: taskText, week: enumWeek)]
            updateTasks(data: result)
            tableView.reloadData()
            
            // очищение после окончания
            alert.textFields?[0].text = ""
            alert.textFields?[1].text = ""
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateVC()
        setupTableView()
    
        picker.dataSource = self
        picker.delegate = self
    }
    
    // MARK: Configurate Navigation and TabBar
    func configurateVC() {
        view.backgroundColor = .systemBackground
        
        // Navigation
        title = "To do list"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(isEdit))
        
        navigationItem.setRightBarButtonItems([plusButton,editButton], animated: true)
        
        // TabBarItem
        tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "doc.plaintext"), selectedImage: UIImage(systemName: "doc.plaintext.fill"))
        tabBarController?.tabBar.backgroundColor = .systemBackground
        //tabBarController?.tabBar.tintColor = .systemBackground
    }

    // MARK: Function rightBarButtonItem
    @objc func addTask() {
        present(alert, animated: true)
    }
    
    @objc func isEdit() {
        if tableView.isEditing == true {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
}



// MARK: SetupTableView
extension ViewController {
    func setupTableView() {
        view.addSubview(tableView)
        
        // для того чтобы работать с ячейкой, нужно поместить ее на нашу таблицу
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "MainViewCell")
        
        // для того чтобы передать данные таблице нужно пользоваться протоколом dataSource
        tableView.dataSource = self
        
        // для того чтобы изменять таблицу - нужен протокол delegate
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tasks.count 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Заглядываем в каждую секцию и получаем кол-во элементов в секции
        tasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // просто запомнить
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as? MainViewCell else { fatalError() }
        
        cell.set(task: tasks[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tasks[indexPath.section].remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let ts = tasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        tasks[destinationIndexPath.section].insert(ts, at: destinationIndexPath.row)
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

// MARK: UPDATE ALERT DATA
extension ViewController {
    func updateTasks(data: [Task]) {
        switch data[0].week {
        case .Monday: tasks[0].append(data[0])
        case .Thursday: tasks[1].append(data[0])
        case .Wednesday: tasks[2].append(data[0])
        case .Tuesday: tasks[3].append(data[0])
        case .Friday: tasks[4].append(data[0])
        case .Saturday: tasks[5].append(data[0])
        case .Sunday: tasks[6].append(data[0])
        }
    }
}

// MARK: UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        tasks.count
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

// MARK: UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0: alert.textFields?[1].text = ".Monday"
        case 1: alert.textFields?[1].text = ".Thursday"
        case 2: alert.textFields?[1].text = ".Wednesday"
        case 3: alert.textFields?[1].text = ".Tuesday"
        case 4: alert.textFields?[1].text = ".Friday"
        case 5: alert.textFields?[1].text = ".Saturday"
        case 6: alert.textFields?[1].text = ".Sunday"
        default: break
        }
    }
}
