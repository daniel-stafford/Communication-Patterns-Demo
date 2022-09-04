//
//  MyView.swift
//  CommunicationPatternsDemo
//
//  Created by Il Capo on 04/09/22.
//

import UIKit

protocol MyViewDelegate: AnyObject {
    func didRequestDelegatePattern(_ sender: MyView, message: String)
}

class MyView: UIView {
    
    weak var delegate: MyViewDelegate?
    
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
        closureButton.configuration?.title = "Closure"
        closureButton.addTarget(self, action: #selector(closureButtonTapped), for: .touchUpInside)
        
        notificationCenterButton.translatesAutoresizingMaskIntoConstraints = false
        notificationCenterButton.configuration = .filled()
        notificationCenterButton.configuration?.title = "Notification Center"
        notificationCenterButton.addTarget(self, action: #selector(notificationCenterButtonTapped), for: .touchUpInside)

        
    }
    
    private func layout() {
        stackView.addArrangedSubviews(delegateButton, closureButton)
        addSubviews(stackView)
        stackView.pinToCenter(of: self)
    }
}

// MARK: Actions
extension MyView {
    @objc func delegateButtonTapped(sender: UIButton) {
        delegate?.didRequestDelegatePattern(self, message: "Delegate button tapped!")
    }
    
    @objc func closureButtonTapped(sender: UIButton) {
        didTapClosureButton?("Closure button tapped")
    }
    
    @objc func notificationCenterButtonTapped(sender: UIButton) {
        
    }
}



