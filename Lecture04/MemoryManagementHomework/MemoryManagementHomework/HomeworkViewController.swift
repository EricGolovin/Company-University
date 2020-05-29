//
//  HomeworkViewController.swift
//  MemoryManagementHomework
//
//  Created by Dmytro Kolesnyk2 on 14.05.2020.
//  Copyright © 2020 Dmytro Kolesnyk. All rights reserved.
//

protocol DetailsSetupProtocol: class {
    func randomString(length: Int) -> String
    func changePictures()
    func callAlert()
}

extension DetailsSetupProtocol {
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in (letters.randomElement() ?? " ") })
    }
}

import UIKit

class HomeworkViewController: UIViewController, DetailsSetupProtocol {
    enum Const {
        static let title = "Homework"
        static let cellReuseIdentifier = "HomeworkCellReuseIdentifier"
        //        static let url = "https://picsum.photos/200/300"  not working
    }
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var pictures: [UIImage] = []
    private var imageFlag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupAutoLayout()
        setupPictures()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSubview() {
        title = Const.title
        tableView.register(HomeworkCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        view.addSubview(tableView)
    }
    
    private func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupPictures() {
        var range: ClosedRange<Int> {
            defer {
                imageFlag.toggle()
            }
            return imageFlag ? 0...10 : 10...20
        }
        if pictures.count > 0 {
            pictures.removeAll()
        }
        for i in range {
            guard let image = UIImage(named: "picture\(i)") else { continue }
            pictures.append(image)
        }
    }
    
    func changePictures() {
        setupPictures()
        tableView.reloadData()
        print("Table was Reloaded")
    }
    
    private func setupTransition(from indexPath: IndexPath) {
        let viewController = DetailsViewController(image: pictures[indexPath.row], delegate: self)
        navigationController?.present(viewController, animated: true)
    }
    
}

extension HomeworkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellReuseIdentifier, for: indexPath) as? HomeworkCell else {
            return HomeworkCell()
        }
        
        cell.homeworkImage = pictures[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ratio = pictures[indexPath.row].getImageRatio()
        return tableView.frame.width / ratio
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupTransition(from: indexPath)
    }
}

extension HomeworkViewController {
    func callAlert() {
        let alert = UIAlertController(title: "Please", message: "Kill or fix me", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: .none))
        
        alert.addAction(UIAlertAction(title: "NO", style: .destructive, handler: nil))
        present(alert, animated: true)
    }
}
