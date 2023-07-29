//
//  ViewController.swift
//  hitTest
//
//  Created by 박종화 on 2023/07/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var orangeView: TestView!
    @IBOutlet weak var greenView: TestView!
    @IBOutlet weak var PurpleView: TestView!
    @IBOutlet weak var blueView: TestView!

    override func viewDidLoad() {
        super.viewDidLoad()
        greenView.backgroundColor = .green

        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        self.greenView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapView(_ gesture: UITapGestureRecognizer) {
        if let greenView = gesture.view {
            if greenView.backgroundColor == .green {
                greenView.backgroundColor = .black
            } else {
                greenView.backgroundColor = .green
            }
        }
    }
}

