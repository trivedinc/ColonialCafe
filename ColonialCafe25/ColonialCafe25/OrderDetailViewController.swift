//
//  OrderDetailViewController.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var order: Order?
    private var orderKey: String?
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Order Details"
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flavorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creamerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let milkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialRequestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    // MARK: - Configuration
    
    func configure(with order: Order, orderKey: String) {
        self.order = order
        self.orderKey = orderKey
        
        if isViewLoaded {
            updateUI()
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(containerView)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(roomLabel)
        containerView.addSubview(typeLabel)
        containerView.addSubview(flavorLabel)
        containerView.addSubview(tempLabel)
        containerView.addSubview(creamerLabel)
        containerView.addSubview(milkLabel)
        containerView.addSubview(specialRequestLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Title label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Container view
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Room label
            roomLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            roomLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            roomLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Type label
            typeLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 12),
            typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            typeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Flavor label
            flavorLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 12),
            flavorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            flavorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Temperature label
            tempLabel.topAnchor.constraint(equalTo: flavorLabel.bottomAnchor, constant: 12),
            tempLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tempLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Creamer label
            creamerLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 12),
            creamerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            creamerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Milk label
            milkLabel.topAnchor.constraint(equalTo: creamerLabel.bottomAnchor, constant: 12),
            milkLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            milkLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Special request label
            specialRequestLabel.topAnchor.constraint(equalTo: milkLabel.bottomAnchor, constant: 12),
            specialRequestLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            specialRequestLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            specialRequestLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        guard let order = order else { return }
        
        nameLabel.text = "Name: \(order.name)"
        roomLabel.text = "Room: \(order.room)"
        typeLabel.text = "Type: \(order.type.rawValue.capitalized)"
        flavorLabel.text = "Flavor: \(order.flavor)"
        
        // Configure based on order type
        if order.type == .coffee {
            tempLabel.text = "Temperature: \(order.temp ?? "N/A")"
            creamerLabel.text = "Creamer: \(order.creamer ?? "N/A")"
            milkLabel.text = "Milk: \(order.milk ?? "N/A")"
            specialRequestLabel.isHidden = true
        } else {
            tempLabel.isHidden = true
            creamerLabel.isHidden = true
            milkLabel.isHidden = true
            specialRequestLabel.isHidden = false
            specialRequestLabel.text = "Special Request: \(order.specialRequest ?? "No special requests")"
        }
    }
}
