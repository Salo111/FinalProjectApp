//
//  ReviewTableView.swift
//  FinalProject
//
//  Created by salo khizanishvili on 16.09.22.
//

import UIKit
import CoreData

var ReviewsList = [MovieReview]()
class ReviewTableView: UITableViewController{
    
    var load = true
    
    func reviewsThatAreNotDeleted() -> [MovieReview]{
        var reviewsThatAreNotDeleted = [MovieReview]()
        for review in ReviewsList {
            if(review.delete == nil){
                reviewsThatAreNotDeleted.append(review)
            }
        }
        return reviewsThatAreNotDeleted
    }
    
    override func viewDidLoad() {
        if(load){
            load = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieReview")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let review = result as! MovieReview
                    ReviewsList.append(review)
                }
            }
            catch{
                print("failed")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCellID", for: indexPath)as! ReviewCell
        let review: MovieReview!
        review = reviewsThatAreNotDeleted()[indexPath.row]
        cell.TitleLbl.text = review.title
        cell.ReviewLbl.text = review.reviewText
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsThatAreNotDeleted().count
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editReview", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editReview"){
            let indexPath = tableView.indexPathForSelectedRow!
            let reviewDeTail = segue.destination as? ReviewDetailVC
            let selectReview : MovieReview!
            selectReview = reviewsThatAreNotDeleted()[indexPath.row]
            reviewDeTail!.selectReview = selectReview
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
