//
//  ViewController.swift
//  BaseProject
//
//  Created by leedongseok on 12/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction private func didTapFirstButton() {
        presentVC()
    }
    private func presentVC() {
        let vc = StarwarsViewController()
        present(vc, animated: true, completion: nil)
    }
 
    @IBAction private func didTapSecondButton() {
        presentVCWithView()
    }
    private func presentVCWithView() {
        let vc = StarwarsViewControllerWithView()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction private func didTapThirdButton() {
        presentVCWithXib()
    }
    private func presentVCWithXib() {
        let vc = StarwarsViewControllerWithXib(nibName: "StarwarsViewControllerWithXib", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
}
