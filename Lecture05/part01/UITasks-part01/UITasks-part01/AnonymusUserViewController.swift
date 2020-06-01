//
//  AnonymusUserViewController.swift
//  UITasks-part01
//
//  Created by Eric Golovin on 01.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class AnonymusUserViewController: UIViewController {
    
    weak var delegate: RegistrationProtocol?
    
    private lazy var imageView: UIImageView = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 150, weight: .medium, scale: .large)
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle", withConfiguration: imageConfig))
        return imageView
    }()
    
    private lazy var sorryLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, register please"
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(sorryLabel)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var customButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Registration", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 25)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateUI()
        
        customButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func updateUI() {
        view.addSubview(stackView)
        view.addSubview(customButton)
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        sorryLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        customButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraits = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            customButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            customButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraits)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if let registerVC = delegate?.registerViewController {
            registerVC.modalPresentationStyle = .fullScreen
            present(registerVC, animated: true, completion: nil)
        }
    }


}
