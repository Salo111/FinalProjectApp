//
//  TypePage.swift
//  FinalProject
//
//  Created by salo khizanishvili on 19.09.22.
//

import UIKit

class TypePage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = storyboard?.instantiateViewController(identifier: "MovieViewController")as! MovieViewController
        if(segue.identifier == "popular"){
            movie = "popular"
        }
        else if(segue.identifier == "now_playing"){
            movie = "now_playing"
        }
        else if(segue.identifier == "top_rated"){
            movie = "top_rated"
        }
        else if(segue.identifier == "upcoming"){
            movie = "upcoming"
        }
    }
}
