//
//  ReviewDetailVC.swift
//  FinalProject
//
//  Created by salo khizanishvili on 16.09.22.
//

import UIKit
import CoreData

class ReviewDetailVC: UIViewController {

    @IBOutlet weak var MovieNameTextField: UITextField!
    @IBOutlet weak var MovieReviewTextView: UITextView!
    var selectReview : MovieReview? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectReview != nil){
            MovieNameTextField.text = selectReview?.title
            MovieReviewTextView.text = selectReview?.reviewText
        }
    }

    @IBAction func saveBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectReview == nil){
            let entity = NSEntityDescription.entity(forEntityName: "MovieReview", in: context)
            let myReview = MovieReview(entity: entity!, insertInto: context)
                myReview.id = ReviewsList.count as NSNumber
                myReview.title = MovieNameTextField.text
                myReview.reviewText = MovieReviewTextView.text
            do{
                try context.save()
                ReviewsList.append(myReview)
                navigationController?.popViewController(animated: true)
            }
            catch{
                print("error")
            }
        }
        else{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieReview")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let review = result as! MovieReview
                    if(review == selectReview){
                        review.title = MovieNameTextField.text
                        review.reviewText = MovieReviewTextView.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch{
                print("failed")
            }
        }
    }
    
    @IBAction func noteDeleteBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieReview")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let review = result as! MovieReview
                if(review == selectReview){
                    review.delete = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch{
            print("failed")
        }
    }
}
