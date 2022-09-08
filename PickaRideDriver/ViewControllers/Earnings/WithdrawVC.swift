//
//  WithdrawVC.swift
//  PickaRideDriver
//
//  Created by Gaurang on 01/09/22.
//

import UIKit

class WithdrawVC: BaseVC {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var submitButton: themeButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setValues()
    }
    
    private func setupUI() {
        setNavigationBarInViewController(controller: self, naviColor: colors.white.value,
                                         naviTitle: NavTitles.WithdrawMoney.value,
                                         leftImage: NavItemsLeft.back.value,
                                         rightImages: [], isTranslucent: false,
                                         CommonViewTitles: [], isTwoLabels: false)
        setupAmountTextField()
        setupAmountButtons()
    }
    
    private func setupAmountTextField() {
        amountTextfield.font = CustomFont.medium.returnFont(24)
        amountTextfield.layer.cornerRadius = 6
        let imageView = UIImageView(image: UIImage(named: "dollar-symbol"))
        amountTextfield.leftView = imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        amountTextfield.leftViewMode = .always
    }
    
    private func setupAmountButtons() {
        let amounts = [10, 20, 30]
        for amount in amounts {
            let button = UIButton(type: .system)
            button.tag = amount
            button.setTitle("+\(amount)", for: .normal)
            button.titleLabel?.font = CustomFont.medium.returnFont(16)
            button.setTitleColor(themeColor, for: .normal)
            button.layer.borderColor = themeColor.cgColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = 6
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonStack.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.addTarget(self, action: #selector(amountTapped(_:)), for: .touchUpInside)
            
        }
        buttonStack.addArrangedSubview(UIView())
    }
    
    private func setValues() {
        balanceLabel.text = 54.74.toCurrencyString()
    }
    
    @IBAction func submitTapped() {
    }
    
    @objc private func amountTapped(_ sender: UIButton) {
        let amount = Double(sender.tag) 
        let inputAmount = Double(amountTextfield.text ?? "") ?? 0
        amountTextfield.text = String(amount + inputAmount)
    }
    
}

