//
//  HomeworkViewController.swift
//  MemoryManagementHomework
//
//  Created by Dmytro Kolesnyk2 on 14.05.2020.
//  Copyright © 2020 Dmytro Kolesnyk. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController {
    enum Const {
        static let title = "Homework"
        static let cellReuseIdentifier = "HomeworkCellReuseIdentifier"
        static let url = "https://picsum.photos/200/300"
    }
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var pictures: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupAutoLayout()
        setupPictures()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func changePictures() {
        pictures = []
        guard let url = URL(string: Const.url) else { return }
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            // MARK: - Solve
            for _ in 0..<20 {
                guard let image = UIImage(url: url) else { continue }
                
                // TODO: Is not working
                self.pictures.append(image)
//                        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//                            guard let self = self, let data = data, let image = UIImage(data: data) else {
//                                return
//                            }
//                            self.pictures.append(image)
//                        }
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.tableView.reloadData()
            })
        }
        
//        tableView.reloadData()
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
        if pictures.count > 0 {
            pictures.removeAll()
        }
        for i in 1...10 {
            guard let image = UIImage(named: "picture\(i)") else { continue }
            pictures.append(image)
        }
    }
    
    private func setupTransition(from indexPath: IndexPath) {
        let viewController = DetailsViewController(image: pictures[indexPath.row], viewController: self, action: { [weak self] (leght: Int) in
            guard let self = self else {
                return "no text"
            }
            return self.randomString(length: leght)
        })
        
        navigationController?.present(viewController, animated: true)
    }
    
    private func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in (letters.randomElement() ?? " ") })
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
