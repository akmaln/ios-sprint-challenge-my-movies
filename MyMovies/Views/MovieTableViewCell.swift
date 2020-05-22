//
//  MovieTableViewCell.swift
//  MyMovies
//
//  Created by Akmal Nurmatov on 5/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie? {
        didSet{
            updateViews()
        }
    }
    
    static let reuseIdentifier = "MyMovieCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasWatchedButton: UIButton!
    
    private func updateViews() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        hasWatchedButton.setImage(movie.hasWatched ? UIImage(systemName: "film.fill") : UIImage(systemName: "film"), for: .normal)
        
    }
    
    @IBAction func toggleHasWatched(_ sender: UIButton) {
        guard let movie = movie else { return }
        
        movie.hasWatched.toggle()
        
        sender.setImage(movie.hasWatched ? UIImage(systemName: "film.fill") : UIImage(systemName: "film"), for: .normal)
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            CoreDataStack.shared.mainContext.reset()
            NSLog("error saving context (changing movie hasWatched boolena): \(error)")
        }
    }
    
    
    

}
