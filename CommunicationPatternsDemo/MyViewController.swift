//
//  MyViewController.swift
//  CommunicationPatternsDemo
//
//  Created by Il Capo on 04/09/22.
//

import UIKit

class MyViewController: UIViewController {
    
    let myView = MyView()
    
    // Closure Pattern #2
    func didTapClosure(message: String) {
        print(message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}



extension MyViewController {
    func setup(){
        // Delegate Pattern #1
        myView.delegate = self
        
        // Closure Pattern #1 (closure pattern #2 needs to be commented out for this to work)
        myView.didTapClosureButton = { [weak self] message in
            print(message)
        }
        
        // Closure Patten #2
        myView.didTapClosureButton = didTapClosure
        
        // Notification Center Pattern
        registerForNotifications()
    }
    
    func style() {
        view.backgroundColor = .systemBackground
        myView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubviews(myView)
        myView.pinToEdges(of: view)
    }
}

// Delegate Pattern
extension MyViewController: MyViewDelegate {
    func didTapDelegateButton(_ sender: MyView, message: String) {
        print(message)
    }
}

// Notification Center Pattern
extension MyViewController {
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapNCButton), name: .didTapNCButton, object: nil)
    }
    
    @objc func didTapNCButton(_ notification: NSNotification){
        guard let userInfo = notification.userInfo else { return }
        if let message = userInfo["message"] as? String {
            print(message)
        }
    }
}

// Responder Chain Pattern
extension MyView: ButtonAction {
    func didTapResponderButton(_ sender: MyView) {
        print(" 🔥 Responder button tapped") // Data cannot be passed via Responder chain
    }
}



