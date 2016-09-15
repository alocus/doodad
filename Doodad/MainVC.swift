//
//  MainVC.swift
//  Doodad
//
//  Created by Michael Dunn on 2016-09-14.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{

    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    var fetchResultController: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // generateTestData()
        attemptFetch()
    }

    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        confgureCell(cell, indexPath: (indexPath as NSIndexPath) as IndexPath)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objects = fetchResultController.fetchedObjects, objects.count > 0 {
            let item = objects[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    
    func confgureCell(_ cell: ItemCell, indexPath: IndexPath){
        // update cell
        let item = fetchResultController.object(at: indexPath as IndexPath)
        cell.configureCell(item)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = fetchResultController.sections{
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    var dateAscending = false
    var priceAscending = true
    var titleAscending = true
    
    // Fetch Request
    func attemptFetch(){
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: dateAscending)
        let priceSort = NSSortDescriptor(key: "price", ascending: priceAscending)
        let titleSort = NSSortDescriptor(key: "title", ascending: titleAscending)
        
        var selectedSortDescriptor = dateSort
        if segment.selectedSegmentIndex == 1 {
            selectedSortDescriptor = priceSort
        } else if segment.selectedSegmentIndex == 2 {
            selectedSortDescriptor = titleSort
        }
        
        fetchRequest.sortDescriptors = [selectedSortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchResultController = controller
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        attemptFetch()
        tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                 tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                // update the cell data
                confgureCell(cell, indexPath: (indexPath as NSIndexPath) as IndexPath)
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }
    
    
    
    func generateTestData(){
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "I need it so I can work build more apps"
        
        let item2 = Item(context: context)
        item2.title = "PS4"
        item2.price = 400
        item2.details = "I will play Final Fantasy when I finish building 300 apps"
        
        let item3 = Item(context: context)
        item3.title = "Tesla"
        item3.price = 120000
        item3.details = "Need a clean car!!"
        
        ad.saveContext()
    }
}

