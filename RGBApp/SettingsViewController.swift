//
//  ViewController.swift
//  RGBApp
//
//  Created by Iliya Mayasov on 06.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var resultColorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redValueTextField: UITextField!
    @IBOutlet weak var greenValueTextField: UITextField!
    @IBOutlet weak var blueValueTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
        resultColorView.layer.cornerRadius = 10
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        guard let colorRGBValues = color.cgColor.components else { return }
        redSlider.value = Float(colorRGBValues[0])
        greenSlider.value = Float(colorRGBValues[1])
        blueSlider.value = Float(colorRGBValues[2])
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        redValueTextField.text = string(from: redSlider)
        greenValueTextField.text = string(from: greenSlider)
        blueValueTextField.text = string(from: blueSlider)
        
        changeViewColor()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setNewColor(for: color)
        dismiss(animated: true)
    }
    
    @IBAction func colorSliderChange(_ sender: UISlider) {
        let numberOfColor = string(from: sender)
        
        switch sender.tag {
        case 0:
            redValueLabel.text = numberOfColor
            redValueTextField.text = numberOfColor
        case 1:
            greenValueLabel.text = numberOfColor
            greenValueTextField.text = numberOfColor
        default:
            blueValueLabel.text = numberOfColor
            blueValueTextField.text = numberOfColor
        }
        
        changeViewColor()
    }
    
    private func changeViewColor() {
        let colorBG = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        resultColorView.backgroundColor = colorBG
        color = colorBG
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard var valueTF = textField.text else { return }
        guard var value = Float(valueTF) else { return }
        
        if value >= 1 {
            value = 1
            valueTF = "1.00"
            textField.text = "1.00"
        }
        
        switch textField.tag {
        case 0:
            redValueLabel.text = valueTF
            redSlider.value = value
        case 1:
            greenValueLabel.text = valueTF
            greenSlider.value = value
        default:
            blueValueLabel.text = valueTF
            blueSlider.value = value
        }
        changeViewColor()
    }
}

// MARK: - Keyboard
extension SettingsViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension UITextField {
    @IBInspectable var doneAccessory: Bool{
        get { self.doneAccessory }
        set (hasDone) {
            if hasDone { addDoneButtonOnKeyboard() }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
// MARK: - UIColor
extension UIColor {
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let components = self.cgColor.components else { return nil }
        return (
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}
