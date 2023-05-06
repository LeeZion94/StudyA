//
//  InterViewController.swift
//  Week2_Zion
//
//  Created by Hyungmin Lee on 2023/05/06.
//
protocol ProductSelectionDelegate {
    func didSelectProduct()
}

class BossViewController {
    var delegate: ProductSelectionDelegate?
    
    @objc func iphoneButtonTapped() {
        delegate?.didSelectProduct()
    }
    
}

class InternViewController: ProductSelectionDelegate {
    func presentBossViewController() {
        let bossViewController = BossViewController()
        bossViewController.delegate = self
        
        self.present(bossViewController)
    }
    
    func didSelectProduct() {
        // Statesments -> Select Product
    }
}
