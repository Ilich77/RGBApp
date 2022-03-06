//
//  ViewController.swift
//  RGBApp
//
//  Created by Iliya Mayasov on 06.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultColorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultColorView.layer.cornerRadius = 10
        changeViewColor()
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        redValueLabel.text = String(round(100 * redSlider.value) / 100)
        greenValueLabel.text = String(round(100 * greenSlider.value) / 100)
        blueValueLabel.text = String(round(100 * blueSlider.value) / 100)
    }

    @IBAction func colorSliderChange(_ sender: UISlider) {
        changeViewColor()
        let numberOfColor = String(round(100 * sender.value) / 100)
        switch sender.tag {
        case 0: redValueLabel.text = numberOfColor
        case 1: greenValueLabel.text = numberOfColor
        default: blueValueLabel.text = numberOfColor
        }
    }
    
    private func changeViewColor() {
        resultColorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                                  green: CGFloat(greenSlider.value),
                                                  blue: CGFloat(blueSlider.value),
                                                  alpha: 1)
    }
}

