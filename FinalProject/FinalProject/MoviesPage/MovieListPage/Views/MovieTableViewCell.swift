//
//  MovieTableViewCell.swift
//  FinalProject
//
//  Created by salo khizanishvili on 19.09.22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var yourRateLbl: UILabel!
    @IBOutlet weak var favouriteHeartBtn: UIButton!
    
    private var urlString: String = ""
    
    // Setup movies values
    
    func setCellWithValuesOf(_ movie: Movie!) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    // Update the UI Views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.movieTitle.text = title
        self.movieYear.text = convertDateFormater(releaseDate)
        guard let rate = rating else {return}
        self.movieRate.text = String(rate)
        self.movieOverview.text = overview
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
    }
    
    // MARK: - Get image data
    func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                //Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                //Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
    
    // MARK: - Convert date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
    
    var numberOfClicks = 0
    @IBAction func heartBtn(_ sender: UIButton) {
        numberOfClicks += 1
        if(numberOfClicks % 2 == 1){
            sender.tintColor = .red
        }
        else{
            sender.tintColor = .black
        }
    }
    
    @IBAction func RateStepper(_ sender: UIStepper) {
        yourRateLbl.text = String(sender.value)
    }
}
