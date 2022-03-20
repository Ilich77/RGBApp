//
//  MainViewController.swift
//  RGBApp
//
//  Created by Iliya Mayasov on 18.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor)
}

class MainViewController: UIViewController {
    var color = UIColor(
        red: CGFloat(1.0),
        green: CGFloat(1.0),
        blue: CGFloat(1.0),
        alpha: 1
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = color
        settingsVC.delegate = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        self.color = color
        self.view.backgroundColor = color
    }
}
