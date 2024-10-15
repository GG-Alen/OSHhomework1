//
//  ViewController.swift
//  AutoLayoutTutorial
//
//  Created by Амир Магомедов on 14.10.2024.
//

import UIKit
let screenSize = UIScreen.main.bounds.size
let screenWidth = screenSize.width
let screenHeight = screenSize.height



class ViewController: UIViewController, UITextViewDelegate {
    

    
    private let enterTextPlaceholder: UILabel = {
        let enterTextPlaceholder = UILabel()
        enterTextPlaceholder.text = "Enter text"
        enterTextPlaceholder.textColor = .darkGray
        enterTextPlaceholder.font = .italicSystemFont(ofSize: 14)
        enterTextPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        return enterTextPlaceholder
    }()
    
    private let typeField: UITextView = {
        let typeField = UITextView()
        typeField.isEditable = true
        typeField.font = .italicSystemFont(ofSize: 14)
        typeField.autocorrectionType = UITextAutocorrectionType.no
        typeField.keyboardType = UIKeyboardType.default
        typeField.translatesAutoresizingMaskIntoConstraints = false
        return typeField
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Text"
        textView.font = .systemFont(ofSize: 30)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.setTitle("Submit text", for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 20
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        return submitButton
    }()
    
    private let editText: UITextView = {
        let editText = UITextView()
        editText.text = "Edit text"
        editText.translatesAutoresizingMaskIntoConstraints = false
        editText.font = .systemFont(ofSize: 16)
        return editText
    }()
    
    private let isRedSwitch: UISwitch = {
        let isRedSwitch = UISwitch()
        isRedSwitch.translatesAutoresizingMaskIntoConstraints = false
        return isRedSwitch
    }()
    
    private let switchLabel: UILabel = {
       let switchLabel = UILabel()
        switchLabel.text = "is red text"
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        return switchLabel
    }()
    
    private let textSizeSlider: UISlider = {
        let textSizeSlider = UISlider()
        textSizeSlider.minimumValue = 4
        textSizeSlider.maximumValue = 46
        textSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        return textSizeSlider
    }()
    
    private var isRedText: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(typeField)
        self.view.addSubview(textView)
        self.view.addSubview(submitButton)
        self.view.addSubview(editText)
        self.view.addSubview(enterTextPlaceholder)
        self.view.addSubview(textSizeSlider)
        
        let stackView = UIStackView(arrangedSubviews: [switchLabel, isRedSwitch])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -100),
            textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            textView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.20),
            
            typeField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            typeField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.20),
            typeField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            typeField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -screenHeight*0.1),
            
            submitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.35),
            
            editText.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20),
            editText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            editText.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.04),
            editText.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            
            enterTextPlaceholder.leadingAnchor.constraint(equalTo: typeField.leadingAnchor, constant: 5),
            enterTextPlaceholder.topAnchor.constraint(equalTo: typeField.topAnchor, constant: 8),
            
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 80),
            
            textSizeSlider.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            textSizeSlider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textSizeSlider.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 120)
            
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChangeWithNotification(_:)), name: UITextView.textDidChangeNotification, object: nil)
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        isRedSwitch.addTarget(self, action: #selector(isRedSwitchTapped), for: .valueChanged)
        
        
    }
    
    @objc private func textViewDidChangeWithNotification(_ notification: Notification) {
        enterTextPlaceholder.isHidden = !typeField.text.isEmpty
    }
    
    @objc func submitButtonTapped(sender: UIButton) {
        textView.text = typeField.text
        textView.textColor = isRedText ? .red : .black
        textView.font = UIFont.systemFont(ofSize: CGFloat(textSizeSlider.value))
    }
    
    @objc func isRedSwitchTapped(sender: UISwitch) {
        isRedText = sender.isOn ? true : false
    }
        


}

