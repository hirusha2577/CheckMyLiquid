//
//  AddDrinksViewController.swift
//  CheckMyLiquid
//
//  Created by Hirusha Ravishan on 2024-04-20.
//

import UIKit

class AddDrinksViewController: UIViewController {

    @IBOutlet weak var drinksPickerView: UIPickerView!
    
    var pickerData = [["Water","Mojito","Juice"],["100","200","500"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drinksPickerView.delegate = self
        drinksPickerView.dataSource = self
    }
    
    
    @IBAction func drinksButtonTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let selectedDrink = drinksPickerView.selectedRow(inComponent: 0)
        let selectedAmount = drinksPickerView.selectedRow(inComponent: 1)
        let saveDrink = pickerData[0][selectedDrink]
        let saveAmount = pickerData[1][selectedAmount]
        let dict = ["drink": saveDrink, "amount": saveAmount]
        
        var drinksArray: [[String: String]] = defaults.value(forKey: "MyDrinks") as? [[String: String]] ?? []
        drinksArray.append(dict)
        defaults.set(drinksArray, forKey: "MyDrinks")
        print(drinksArray)
        
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableData"), object: nil)

    }
    
}

extension AddDrinksViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    
}
