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
        print(message, "alternative syntax")
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
        // Delegate Pattern
        myView.delegate = self
        
        // Closure Pattern
        myView.didTapClosureButton = { [weak self] message in
            print(message)
        }
        
        // Closure Patten # 2
        myView.didTapClosureButton = didTapClosure

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
    func didRequestDelegatePattern(_ sender: MyView, message: String) {
        print(message)
    }
}

