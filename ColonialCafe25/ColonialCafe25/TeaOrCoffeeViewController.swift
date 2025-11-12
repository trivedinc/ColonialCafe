//
//  TeaOrCoffeeViewController.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//

import UIKit

class TeaOrCoffeeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Colonial Cafe"
        label.font = UIFont(name: "Avenir-Heavy", size: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "What would you like to order today?"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tea_image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let coffeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coffee_image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let teaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tea", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let coffeeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Coffee", for: .normal)
        button.backgroundColor = .systemBrown
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(questionLabel)
        view.addSubview(teaImageView)
        view.addSubview(coffeeImageView)
        view.addSubview(teaButton)
        view.addSubview(coffeeButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Title label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Question label
            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Tea image
            teaImageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            teaImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            teaImageView.widthAnchor.constraint(equalToConstant: 120),
            teaImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Coffee image
            coffeeImageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            coffeeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            coffeeImageView.widthAnchor.constraint(equalToConstant: 120),
            coffeeImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Tea button
            teaButton.topAnchor.constraint(equalTo: teaImageView.bottomAnchor, constant: 20),
            teaButton.centerXAnchor.constraint(equalTo: teaImageView.centerXAnchor),
            teaButton.widthAnchor.constraint(equalToConstant: 120),
            teaButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Coffee button
            coffeeButton.topAnchor.constraint(equalTo: coffeeImageView.bottomAnchor, constant: 20),
            coffeeButton.centerXAnchor.constraint(equalTo: coffeeImageView.centerXAnchor),
            coffeeButton.widthAnchor.constraint(equalToConstant: 120),
            coffeeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupActions() {
        teaButton.addTarget(self, action: #selector(teaButtonTapped), for: .touchUpInside)
        coffeeButton.addTarget(self, action: #selector(coffeeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func teaButtonTapped() {
        performSegue(withIdentifier: "teaOrderSegue", sender: nil)
    }
    
    @objc private func coffeeButtonTapped() {
        performSegue(withIdentifier: "coffeeOrderSegue", sender: nil)
    }
}
