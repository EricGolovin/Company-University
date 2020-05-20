//
//  DetailsViewController.swift
//  MemoryManagementHomework
//
//  Created by Dmytro Kolesnyk2 on 14.05.2020.
//  Copyright © 2020 Dmytro Kolesnyk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    private let image: UIImage

    weak private var viewController: HomeworkViewController?
    private lazy var imageView = UIImageView()
    private lazy var textLabel = UILabel()
    private lazy var stackView = UIStackView()
    private var getImageAction: (() -> UIImage)?
    private var onDoneAction: (() -> ())?
    private var configureTextAction: ((Int) -> String)?
    
    init(image: UIImage, viewController: HomeworkViewController, action: @escaping (Int) -> String) {
        self.image = image
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
        
        getImageAction = { [weak self] in
            if let self = self {
                return self.image
            } else {
                return UIImage()
            }
        }
        configureTextAction = action
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupAutoLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onDoneAction?()
        onDoneAction = nil
        viewController = nil
        getImageAction = nil
    }
    
    func setupText(text: String) {
        textLabel.text = text
    }
    
    func setupSubviews() {
        view.addSubview(stackView)
        stackView.addSubview(imageView)
        stackView.addSubview(textLabel)
        view.backgroundColor = .white
        imageView.image = getImageAction?()
        viewController?.changePictures()
        textLabel.numberOfLines = 0
        self.textLabel.text = configureTextAction!(1200)
        
        // MARK: - Possible Memory Leak
        onDoneAction = { [weak self] in
            if let self = self {
                self.viewController?.callAlert()
                self.viewController?.changePictures()
            }
        }
    }
    
    func setupAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let height = view.frame.width / image.getImageRatio()
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            textLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: height),
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor)
        ])
    }
    
    deinit {
        print("deinit: DetailsViewController")
    }
}
