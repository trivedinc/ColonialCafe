//
//  OrdersViewController.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//


import UIKit
import Firebase

class OrdersViewController: UIViewController {
    
    // MARK: - Properties
    
    private var orders: [String: Order] = [:]
    private var orderKeys: [String] = []
    private var selectedOrderKey: String?
    private var selectedOrder: Order?
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Colonial Cafe Orders"
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupActions()
        fetchOrders()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(refreshButton)
        view.addSubview(tableView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Title label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Refresh button
            refreshButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            refreshButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Table view
            tableView.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupActions() {
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Data Fetching
    
    private func fetchOrders() {
        FirebaseService.shared.fetchOrders { [weak self] orders in
            guard let self = self else { return }
            
            self.orders = orders
            self.orderKeys = Array(orders.keys).sorted()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func refreshButtonTapped() {
        fetchOrders()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView",
           let detailVC = segue.destination as? OrderDetailViewController,
           let selectedOrder = selectedOrder,
           let selectedOrderKey = selectedOrderKey {
            detailVC.configure(with: selectedOrder, orderKey: selectedOrderKey)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        
        let orderKey = orderKeys[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.row + 1). \(orderKey)"
        content.textProperties.color = .label
        content.textProperties.font = UIFont(name: "Avenir Next", size: 18) ?? .systemFont(ofSize: 18)
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let orderKey = orderKeys[indexPath.row]
        guard let order = orders[orderKey] else { return }
        
        selectedOrderKey = orderKey
        selectedOrder = order
        
        performSegue(withIdentifier: "toDetailView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let orderKey = orderKeys[indexPath.row]
            
            FirebaseService.shared.deleteOrder(withKey: orderKey) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error deleting order: \(error.localizedDescription)")
                    return
                }
                
                self.orders.removeValue(forKey: orderKey)
                self.orderKeys.remove(at: indexPath.row)
                
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}

