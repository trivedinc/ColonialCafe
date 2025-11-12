//
//  UIComponents.swift
//  ColonialCafe25
//
//  Created by Rishi Gandhi on 4/28/25.
//

import UIKit

// Modern replacement for the DropDown library
class ModernDropdown: UIView {
    private let tableView = UITableView()
    private let options: [String]
    private var selectedOption: String?
    private var onSelection: ((String, Int) -> Void)?
    
    init(options: [String], frame: CGRect = .zero) {
        self.options = options
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray4.cgColor
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func onSelect(completion: @escaping (String, Int) -> Void) {
        self.onSelection = completion
    }
    
    func show(in view: UIView, anchorView: UIView) {
        // Calculate position relative to anchorView
        let anchorFrame = anchorView.convert(anchorView.bounds, to: view)
        
        // Set frame for dropdown
        let height = min(CGFloat(options.count * 44), 200)
        frame = CGRect(
            x: anchorFrame.minX,
            y: anchorFrame.maxY + 5,
            width: anchorFrame.width,
            height: height
        )
        
        // Add to view and bring to front
        view.addSubview(self)
        view.bringSubviewToFront(self)
        
        // Animate appearance
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension ModernDropdown: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = options[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOption = options[indexPath.row]
        self.selectedOption = selectedOption
        onSelection?(selectedOption, indexPath.row)
        dismiss()
    }
}

// Modern alert controller helper
class AlertManager {
    static func showAlert(title: String, message: String, on viewController: UIViewController, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        viewController.present(alert, animated: true)
    }
}
