//
//  OrderCoffeeViewController.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//

import UIKit
import Firebase

class OrderCoffeeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var selectedFlavor: String = "Select...."
    private var selectedTemp: String = "Select...."
    private var selectedCreamer: String = "Select...."
    private var selectedMilk: String = "Select...."
    
    private let flavorOptions = ["Regular", "Cinnamon sticky bun"]
    private let tempOptions = ["Hot", "Cold"]
    private let creamerOptions = ["Regular", "French vanilla", "Hazelnut"]
    private let milkOptions = ["Regular", "Almond", "Oat"]
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Order Coffee"
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let roomTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Room Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let flavorLabel: UILabel = {
        let label = UILabel()
        label.text = "Flavor:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flavorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select....", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Temperature:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select....", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let creamerLabel: UILabel = {
        let label = UILabel()
        label.text = "Creamer:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creamerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select....", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let milkLabel: UILabel = {
        let label = UILabel()
        label.text = "Milk:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let milkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select....", for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let placeOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Place Order", for: .normal)
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
        view.addSubview(nameTextField)
        view.addSubview(roomTextField)
        view.addSubview(flavorLabel)
        view.addSubview(flavorButton)
        view.addSubview(tempLabel)
        view.addSubview(tempButton)
        view.addSubview(creamerLabel)
        view.addSubview(creamerButton)
        view.addSubview(milkLabel)
        view.addSubview(milkButton)
        view.addSubview(placeOrderButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Title label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Name text field
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Room text field
            roomTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            roomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            roomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            roomTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Flavor label
            flavorLabel.topAnchor.constraint(equalTo: roomTextField.bottomAnchor, constant: 24),
            flavorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            flavorLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Flavor button
            flavorButton.centerYAnchor.constraint(equalTo: flavorLabel.centerYAnchor),
            flavorButton.leadingAnchor.constraint(equalTo: flavorLabel.trailingAnchor, constant: 10),
            flavorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            flavorButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Temperature label
            tempLabel.topAnchor.constraint(equalTo: flavorLabel.bottomAnchor, constant: 24),
            tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tempLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Temperature button
            tempButton.centerYAnchor.constraint(equalTo: tempLabel.centerYAnchor),
            tempButton.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            tempButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tempButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Creamer label
            creamerLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 24),
            creamerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            creamerLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Creamer button
            creamerButton.centerYAnchor.constraint(equalTo: creamerLabel.centerYAnchor),
            creamerButton.leadingAnchor.constraint(equalTo: creamerLabel.trailingAnchor, constant: 10),
            creamerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            creamerButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Milk label
            milkLabel.topAnchor.constraint(equalTo: creamerLabel.bottomAnchor, constant: 24),
            milkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            milkLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Milk button
            milkButton.centerYAnchor.constraint(equalTo: milkLabel.centerYAnchor),
            milkButton.leadingAnchor.constraint(equalTo: milkLabel.trailingAnchor, constant: 10),
            milkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            milkButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Place order button
            placeOrderButton.topAnchor.constraint(equalTo: milkLabel.bottomAnchor, constant: 40),
            placeOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            placeOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            placeOrderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Add delegates for text fields
        nameTextField.delegate = self
        roomTextField.delegate = self
        
        // Add button actions
        flavorButton.addTarget(self, action: #selector(showFlavorDropdown), for: .touchUpInside)
        tempButton.addTarget(self, action: #selector(showTempDropdown), for: .touchUpInside)
        creamerButton.addTarget(self, action: #selector(showCreamerDropdown), for: .touchUpInside)
        milkButton.addTarget(self, action: #selector(showMilkDropdown), for: .touchUpInside)
        placeOrderButton.addTarget(self, action: #selector(placeOrderTapped), for: .touchUpInside)
    }
    
    // MARK: - Dropdown Methods
    
    @objc private func showFlavorDropdown() {
        let dropdown = ModernDropdown(options: flavorOptions)
        dropdown.onSelect { [weak self] option, index in
            self?.selectedFlavor = option
            self?.flavorButton.setTitle(option, for: .normal)
        }
        dropdown.show(in: view, anchorView: flavorButton)
    }
    
    @objc private func showTempDropdown() {
        let dropdown = ModernDropdown(options: tempOptions)
        dropdown.onSelect { [weak self] option, index in
            self?.selectedTemp = option
            self?.tempButton.setTitle(option, for: .normal)
        }
        dropdown.show(in: view, anchorView: tempButton)
    }
    
    @objc private func showCreamerDropdown() {
        let dropdown = ModernDropdown(options: creamerOptions)
        dropdown.onSelect { [weak self] option, index in
            self?.selectedCreamer = option
            self?.creamerButton.setTitle(option, for: .normal)
        }
        dropdown.show(in: view, anchorView: creamerButton)
    }
    
    @objc private func showMilkDropdown() {
        let dropdown = ModernDropdown(options: milkOptions)
        dropdown.onSelect { [weak self] option, index in
            self?.selectedMilk = option
            self?.milkButton.setTitle(option, for: .normal)
        }
        dropdown.show(in: view, anchorView: milkButton)
    }
    
    // MARK: - Actions
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func placeOrderTapped() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Enter a name for this order", message: "No name was entered for this order.")
            return
        }
        
        guard let room = roomTextField.text, !room.isEmpty else {
            showAlert(title: "Enter a room number for this order", message: "No room number was entered for this order.")
            return
        }
        
        if selectedFlavor == "Select...." || selectedTemp == "Select...." || selectedCreamer == "Select...." || selectedMilk == "Select...." {
            showAlert(title: "Please complete your order", message: "One or more parts of your order are missing.")
            return
        }
        
        // Create order
        let order = Order(
            name: name,
            room: room,
            type: .coffee,
            flavor: selectedFlavor,
            specialRequest: nil,
            creamer: selectedCreamer,
            milk: selectedMilk,
            temp: selectedTemp
        )
        
        // Save to Firebase
        FirebaseService.shared.saveOrder(order, withName: name, room: room) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Error", message: "Failed to place order: \(error.localizedDescription)")
                return
            }
            
            self.showAlert(
                title: "Order Complete",
                message: "Thank you for your order! You will receive it shortly.",
                completion: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            )
        }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension OrderCoffeeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            roomTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
