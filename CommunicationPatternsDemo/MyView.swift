//
//  MyView.swift
//  CommunicationPatternsDemo
//
//  Created by Il Capo on 04/09/22.
//

import UIKit

// Delegate Pattern
protocol MyViewDelegate: AnyObject {
    func didRequestDelegatePattern(_ sender: MyView, message: String)
}

class MyView: UIView {
    
    // Delegate Pattern
    weak var delegate: MyViewDelegate?
    
    // Closure Pattern
    var didTapClosureButton: ((String)-> Void)?
    
    let stackView = UIStackView()

    let delegateButton = UIButton(type: .system)
    let closureButton = UIButton(type: .system)
    let notificationCenterButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyView {
    
    private func style() {
        backgroundColor = .systemGreen

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        delegateButton.translatesAutoresizingMaskIntoConstraints = false
        delegateButton.configuration = .filled()
        delegateButton.configuration?.title = "Delegate"
        delegateButton.addTarget(self, action: #selector(delegateButtonTapped), for: .touchUpInside)
        
        closureButton.translatesAutoresizingMaskIntoConstraints = false
        closureButton.configuration = .filled()
        closureButton.configuration?.baseBackgroundColor = .systemRed
        closureButton.configuration?.title = "Closure"
        closureButton.addTarget(self, action: #selector(closureButtonTapped), for: .touchUpInside)
        
        notificationCenterButton.translatesAutoresizingMaskIntoConstraints = false
        notificationCenterButton.configuration = .filled()
        notificationCenterButton.configuration?.baseBackgroundColor = .systemGray
        notificationCenterButton.configuration?.title = "Notification Center"
        notificationCenterButton.addTarget(self, action: #selector(notificationCenterButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        stackView.addArrangedSubviews(delegateButton, closureButton, notificationCenterButton)
        addSubviews(stackView)
        stackView.pinToCenter(of: self)
    }
}

extension MyView {
    // Delegate Pattern
    @objc func delegateButtonTapped(sender: UIButton) {
        delegate?.didRequestDelegatePattern(self, message: "👍 Delegate button tapped!")
    }
   
    // Closure Pattern
    @objc func closureButtonTapped(sender: UIButton) {
        didTapClosureButton?("⚡ Closure button tapped!")
    }
   
    // Notification Pattern
    @objc func notificationCenterButtonTapped(sender: UIButton) {
        let userInfo = [String: String]()
        NotificationCenter.default.post(name: .didTapNCButton, object: nil, userInfo: userInfo)  // not sure when to use object vs. userInfo

    }
}



