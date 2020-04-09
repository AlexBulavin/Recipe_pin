//
//  RecipesTableViewController.swift
//  FoodPin
//
//  Created by Alex on 19.03.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery" , "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Ko ng", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", " British", "Thai"]
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecipeTableViewCell
        // Configure the cell...
        cell.nameLabel?.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView?.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel?.text = restaurantLocations[indexPath.row]
        cell.typeLabel?.text = restaurantTypes[indexPath.row]
        //        if restaurantIsVisited[indexPath.row] { cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        } //Альтернативная форма оператора cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        
        cell.heartImageView.isHidden = !self.restaurantIsVisited[indexPath.row]
        
        // tableView.separatorStyle = UITableViewCell.SeparatorStyle(rawValue: 0)! //Избавляемся от сепаратора между ячейками. Это же сделано в Storyboard через атрибут сепаратора
        
        return cell }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath
        : IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "Что Вы хотите сделать?", preferredStyle: .actionSheet) //.alert) это опциональное оформление сообщения. Алерт или actionSheet
        
        if let popoverController = optionMenu.popoverPresentationController { if let cell = tableView.cellForRow(at: indexPath) {
            popoverController.sourceView = cell
            popoverController.sourceRect = cell.bounds }
        }
        
        // Add actions to the menu
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Сервис временно недоступен", message: "Извините, сервис пока не доступен, пожалуйста попробуйте позже.",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        // Add Call action
        let callAction = UIAlertAction(title: "Позвонить " + "123-000-\(indexPath.row)" , style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        //Add cancel action
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Check-in action
        let checkInTitle = self.restaurantIsVisited[indexPath.row] ? "Удалить из избранноого" : "Добавить в избранное"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell
            
            
            // Solution to exercise 1
            //            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .none : .checkmark
            
            // Solution to exercise 2
            // We use the isHidden property to control whether the image view is displayed or not
            cell?.heartImageView.isHidden = self.restaurantIsVisited[indexPath.row]
            
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
            //
            //        let checkInAction = if restaurantIsVisited[indexPath.row] { UIAlertAction(title: "Удалить из избранноого", style: .default, handler: {
            //            (action:UIAlertAction!) -> Void in
            //            let cell = tableView.cellForRow(at: indexPath)
            //            cell?.accessoryType = .none
            //            self.restaurantIsVisited[indexPath.row] = false
            //            })} else {
            //                UIAlertAction(title: "Добавить в избранное", style: .default, handler: {
            //                (action:UIAlertAction!) -> Void in
            //                let cell = tableView.cellForRow(at: indexPath)
            //                    cell?.accessoryType = .checkmark //UIImage(named: "heart-tick")
            //                self.restaurantIsVisited[indexPath.row] = true
        })
        
        optionMenu.addAction(checkInAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        //Убрали индикацию выбора ячейки после того, как отобразился чекпоинт "избранное"
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true //Для корректного отображения ячеек на планшетах.
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { //Добавлена нативная функция удаления ячейки. Свайп влево активирует кнопку удаления.
    //        if editingStyle == .delete {
    //            // Delete the row from the data source
    //            restaurantNames.remove(at: indexPath.row)
    //            restaurantLocations.remove(at: indexPath.row)
    //            restaurantTypes.remove(at: indexPath.row)
    //            restaurantIsVisited.remove(at: indexPath.row)
    //            restaurantImages.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)//Удаление конкретной строки с анимацией .fade
    //                //Также возможны .right , .left , and .top
    //        }
    //        print("Total items: \(restaurantNames.count)")
    //        for name in restaurantNames {//Выводм на печать наименования ресторанов и их оставшееся количество.
    //            print(name)
    //        }
    //    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete")//.destructive style, indicating that the button should be in red.
        { (action, sourceView, completionHandler) in
            // Delete the row from the data source
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)//Удаление конкретной строки с анимацией .fade
            //Также возможны .right , .left , and .top
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        let shareAction = UIContextualAction(style: .normal, title: "Поделиться") { (action, sourceView, completionHandler) in
            let defaultText = "Рекомендую посетить: " + self.restaurantNames[indexPath.row] + " " + self.restaurantTypes[indexPath.row] + "\nАдрес " + self.restaurantLocations[indexPath.row]
            
            let activityController: UIActivityViewController
            
            if let defaultPicture = UIImage(named: self.restaurantImages[indexPath.row])
            { activityController = UIActivityViewController(activityItems: [ defaultText, defaultPicture], applicationActivities: nil) }
            else
            { activityController = UIActivityViewController(activityItems: [ defaultText], applicationActivities: nil) }
            
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath) { popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                } }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0 , blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.title = "Удалить"
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0 , blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let checkAction = UIContextualAction(style: .normal, title: "Выбрать")
        { (action, sourceView, completionHandler) in
           
            let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell
            
            cell?.heartImageView.isHidden = self.restaurantIsVisited[indexPath.row]
            
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
            
            completionHandler(true)
        }
        checkAction.image = (checkAction.image != nil) ? UIImage(systemName: "checkmark") : UIImage(systemName: "arrow.uturn.left")
        checkAction.backgroundColor = UIColor(red: 26.0/255.0, green: 163.0/255.0 , blue: 74.0/255.0, alpha: 1.0)
        //          TODO: Добваить на свайп влево действие аналогичное добавлению в избранное или удалению из него
        //    arrow.uturn.left
        //    checkmark
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        return swipeConfiguration
        
    }
}
