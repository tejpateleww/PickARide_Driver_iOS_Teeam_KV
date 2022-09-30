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
        let label = UILabel(frame: .zero)
        label.text = SingletonClass.sharedInstance.currencySymbol
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.sizeToFit()
        amountTextfield.leftView = label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
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
        balanceLabel.text = SingletonClass.sharedInstance.balance?.toCurrencyString()
    }
    
    @IBAction func submitTapped() {
        guard (amountTextfield.text ?? "").isEmpty == false else {
            return
        }
        Utilities.showHUD()
        WebServiceSubClass.withdrawMoney(amount: amountTextfield.text ?? "") { (status, _, model, _) in
            Utilities.hideHUD()
            if status {
                SingletonClass.sharedInstance.balance = model?.totalEarning
            }
            let okAction = UIAlertAction(title: "OK", style: .default) {[unowned self] _ in
                if status {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            self.showAlert(message: model?.message ?? "", alertActions: [okAction])
        }
    }
    
    @objc private func amountTapped(_ sender: UIButton) {
        let amount = Double(sender.tag) 
        let inputAmount = Double(amountTextfield.text ?? "") ?? 0
        amountTextfield.text = String(amount + inputAmount)
    }
    
}

