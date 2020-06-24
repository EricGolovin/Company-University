import UIKit

public protocol MovieRatingStrategy {
    var ratingServiceName: String { get }
    func fetchRating(for movieTitle: String, success: (_ rating: String, _ review: String) -> ())
}

public class RottenTomatoesClient: MovieRatingStrategy {
    public let ratingServiceName: String = "Rotten Tomatoes"
    
    public func fetchRating(for movieTitle: String, success: (String, String) -> ()) {
        // Network request...
        
        let rating = "99%"
        let review = "It rocked!"
        
        success(rating, review)
    }
}

public class IMDbClient: MovieRatingStrategy {
    public let ratingServiceName: String = "IMDb"
    
    public func fetchRating(for movieTitle: String, success: (String, String) -> ()) {
        // Network request...
        
        let rating = "3 / 10"
        let review = "Bad"
        
        success(rating, review)
    }
}

public class MovieRatingViewController: UIViewController {
    
    // MARK: - Properties
    public var movieRatingClient: MovieRatingStrategy!
    
    // MARK: - Outlets
    lazy public var movieTitleTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    lazy public var ratingServiceNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    lazy public var ratingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    lazy public var reviewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        return label
    }()
    lazy public var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(searchButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        movieRatingClient = IMDbClient()
        ratingServiceNameLabel.text = movieRatingClient.ratingServiceName
        
    }
    
    @objc public func searchButtonPressed(sender: UIButton) {
        guard let movieTitle = movieTitleTextField.text else { return }
        
        movieRatingClient.fetchRating(for: movieTitle, success: { rating, review in
            self.ratingLabel.text = rating
            self.reviewLabel.text = review
        })
    }
}
