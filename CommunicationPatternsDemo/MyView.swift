//
//  MyView.swift
//  CommunicationPatternsDemo
//
//  Created by Il Capo on 04/09/22.
//

import UIKit

// Delegate Pattern
protocol MyViewDelegate: AnyObject {
    func didTapDelegateButton(_ sender: MyView, message: String)
}

// Responder Pattern
@objc protocol ButtonAction: AnyObject { // @objc to make it visible to the Objective-C runtime.
    func didTapResponderButton(_ sender: MyView)
}

// KVO Pattern
@objc class KVOMessage: NSObject {
    @objc dynamic var text = "Initial KVO message" // dynamic = bridges objc and swift
}

class MyView: UIView {
    
    // Delegate Pattern
    weak var delegate: MyViewDelegate?
    
    // Closure Pattern
    var didTapClosureButton: ((String)-> Void)?
   
    // KVO Pattern
    @objc let kvoMessage = KVOMessage()
    
    let stackView = UIStackView()
    let delegateButton = UIButton(type: .system)
    let closureButton = UIButton(type: .system)
    let notificationCenterButton = UIButton(type: .system)
    let responderButton = UIButton(type: .system)
    let kvoButton = UIButton(type: .system)
    
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
        
        responderButton.translatesAutoresizingMaskIntoConstraints = false
        responderButton.configuration = .filled()
        responderButton.configuration?.baseBackgroundColor = .systemBrown
        responderButton.configuration?.title = "Responder Chain"
        // Responder Chain Pattern
        responderButton.addTarget(nil, action: #selector(ButtonAction.didTapResponderButton), for: .touchUpInside)
        
        kvoButton.translatesAutoresizingMaskIntoConstraints = false
        kvoButton.configuration = .filled()
        kvoButton.configuration?.baseBackgroundColor = .systemGray
        kvoButton.configuration?.title = "Key-Value Observing"
        kvoButton.addTarget(self, action: #selector(kvoButtonTapped), for: .touchUpInside)

    }
    
    private func layout() {
        stackView.addArrangedSubviews(delegateButton, closureButton, notificationCenterButton, responderButton, kvoButton)
        addSubviews(stackView)
        stackView.pinToCenter(of: self)
    }
}

extension MyView {
    // Delegate Pattern
    @objc func delegateButtonTapped(sender: UIButton) {
        delegate?.didTapDelegateButton(self, message: "👍 Delegate button tapped!")
    }
   
    // Closure Pattern
    @objc func closureButtonTapped(sender: UIButton) {
        didTapClosureButton?("⚡ Closure button tapped!")
    }
   
    // Notification Pattern
    @objc func notificationCenterButtonTapped(sender: UIButton) {
        let userInfo = [ "message" : "🚀 Notification button tapped" ]
        NotificationCenter.default.post(name: .didTapNCButton, object: nil, userInfo: userInfo)  // not sure when to use object vs. userInfo
    }
   
    // KVO Pattern
    @objc func kvoButtonTapped(sender: UIButton ) {
        kvoMessage.text = "👻 KVO button tapped"
    }
}



