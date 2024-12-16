//
//  ViewController.swift
//  TicketQueueAnimation
//
//  Created by Kosal Pen on 16/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    // -- Property
    let showAnimationButton: UIButton = {
        let _button = UIButton(type: .system)
        _button.setTitle("Show Animation", for: .normal)
        _button.translatesAutoresizingMaskIntoConstraints = false
        return _button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(showAnimationButton)
        NSLayoutConstraint.activate([
            showAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAnimationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        // Add target-action for the button tap
        showAnimationButton.addTarget(
            self,
            action: #selector(showAnimationButtonAction),
            for: .touchUpInside
        )
    }
    
    // -- Action
    @IBAction func showAnimationButtonAction() {
        
        let vc = TicketQueueViewController(segmentQueue: [3, 7, 13, 20])
        vc.completion = {
            print("done")
        }
        
        vc.cancelCompletion = {
            print("Cancel")
        }
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

