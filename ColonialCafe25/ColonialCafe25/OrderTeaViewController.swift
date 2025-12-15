//
//  OrderTeaViewController.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//


import UIKit
import Firebase

class OrderTeaViewController: UIViewController {
    
    // MARK: - Properties
    
    private var selectedFlavor: String = "Select...."
    private var specialRequest: String = "No special requests"
    
    private let flavorOptions = ["Green Tea", "Black Tea", "Herbal Tea", "Chai Tea"]
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Order Tea"
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
        label.text = "Tea Type:"
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let specialRequestLabel: UILabel = {
        let label = UILabel()
        label.text = "Special Requests:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialRequestTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let placeOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Place Order", for: .normal)
        button.backgroundColor = .systemGreen
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
        view.addSubview(specialRequestLabel)
        view.addSubview(specialRequestTextView)
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
            
            // Special request label
            specialRequestLabel.topAnchor.constraint(equalTo: flavorLabel.bottomAnchor, constant: 24),
            specialRequestLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            specialRequestLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Special request text view
            specialRequestTextView.topAnchor.constraint(equalTo: specialRequestLabel.bottomAnchor, constant: 8),
            specialRequestTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            specialRequestTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            specialRequestTextView.heightAnchor.constraint(equalToConstant: 100),
            
            // Place order button
            placeOrderButton.topAnchor.constraint(equalTo: specialRequestTextView.bottomAnchor, constant: 40),
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
        specialRequestTextView.delegate = self
        
        // Add button actions
        flavorButton.addTarget(self, action: #selector(showFlavorDropdown), for: .touchUpInside)
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
        
        if selectedFlavor == "Select...." {
            showAlert(title: "Please select a tea type", message: "You need to select a tea type for your order.")
            return
        }
        
        // Get special request if any
        if let requestText = specialRequestTextView.text, !requestText.isEmpty {
            specialRequest = requestText
        }
        
        // Create order
        let order = Order(
            name: name,
            room: room,
            type: .tea,
            flavor: selectedFlavor,
            specialRequest: specialRequest
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

extension OrderTeaViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            roomTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - UITextViewDelegate

extension OrderTeaViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "No special requests" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "No special requests"
        }
    }
}
