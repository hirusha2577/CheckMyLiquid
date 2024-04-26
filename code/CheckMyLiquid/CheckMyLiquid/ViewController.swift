//
//  ViewController.swift
//  CheckMyLiquid
//
//  Created by Hirusha Ravishan on 2024-04-13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var juiceLable: UILabel!
    @IBOutlet weak var mojitoLable: UILabel!
    @IBOutlet weak var waterLable: UILabel!
    
    let defaults = UserDefaults.standard
    var drinksArray: [[String: String]] = []
    
    var waterArray: [Int] = []
    var mojitoArray: [Int] = []
    var juiceArray: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadTableData"), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    @objc func reloadData() {
        drinksArray = UserDefaults.standard.value(forKey: "MyDrinks") as? [[String: String]] ?? []
        getDrinks()
        tableView?.reloadData()
        
        waterLable.text = "\(String(waterArray.reduce(0, +))) ml"
        mojitoLable.text = "\(String(mojitoArray.reduce(0, +))) ml"
        juiceLable.text = "\(String(juiceArray.reduce(0, +))) ml"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func addDrinksButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "drinks", sender: self)
    }
    
    @IBAction func deleteAllDrinksTapped(_ sender: Any) {
        
        let sheet = UIAlertController(title: "Warning!", message: "Are you suer to delete All?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               sheet.addAction(UIAlertAction(title: "Delete All", style: .destructive, handler: { _ in
                   self.drinksArray.removeAll()
                   self.defaults.set(self.drinksArray, forKey: "MyDrinks")
                   self.viewWillAppear(true)
               }))
               present(sheet, animated: true)
        
       
    }
        
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DrinksTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! DrinksTableViewCell
        
        let drink = drinksArray[indexPath.row]["drink"]
        let amount = drinksArray[indexPath.row]["amount"]
        
        cell.drink.text = drink
        cell.amount.text = "\(amount ?? "") ml"
        
        if drink == "Water" {
            cell.drinkImage.image  = UIImage(named: "water")
        }else if drink == "Mojito" {
            cell.drinkImage.image = UIImage(named: "mojito")
        }else if drink == "Juice" {
            cell.drinkImage.image = UIImage(named: "juice")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        let sheet = UIAlertController(title: "Warning!", message: "Are you suer to delete?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                   if editingStyle == .delete {
                       print("Delete Row")
                       self.drinksArray.remove(at: indexPath.row)
                       tableView.deleteRows(at: [indexPath], with: .automatic)
                       self.defaults.set(self.drinksArray, forKey: "MyDrinks")
                       self.viewWillAppear(true)
                   }
               }))
               present(sheet, animated: true)

    
    }
}

extension ViewController {
    func getDrinks(){
        
        waterArray.removeAll()
        mojitoArray.removeAll()
        juiceArray.removeAll()
        
        for drink in drinksArray {
            let fluid = drink["drink"]
            let ml = drink["amount"]
            let intMl = Int(ml!)
            
            if fluid == "Water" {
                waterArray.append(intMl!)
            }else if fluid == "Mojito" {
                mojitoArray.append(intMl!)
            }else if fluid == "Juice" {
                juiceArray.append(intMl!)
            }
        }
    }
}

