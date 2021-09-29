import Foundation
import SwiftUI

class Completed_BusinessListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var radius: Int = 1
    
    @Published var businesses: [Business] = []
    @Published var highestRatedId: String? = nil
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
  
    func getPlaces() {
        // MARK: Clearing the businesses array

        // - if the text field is empty, empty the list of businesses and
        // - skip the API call
        
        if searchTerm == "" {
            businesses = []
            return
        }
        
        YelpService.getBusinesses(term: searchTerm, radius: radius) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let businesses):
                    self.businesses = businesses
                    self.highestRatedId = self.getBestRestaurantId(businesses: businesses)
                case .failure(let error):
                    self.errorMessage = error.rawValue
                    self.showError = true
                }
            }
        }
    }
    
    func getBestRestaurantId(businesses: [Business]) -> String? {
        // Return the id of the business with the highest rating
        // - Loop through the businesses array
        // - Keep track of the current winner
        // - If the rating of the business you're looking at is higher than the current winner's
        // - Reassign the current winner to the one you're looking at
        // - Once we've looped through all elements, our current winner will be the overall winner
        // - Return its id
        
        var currentHighestRatedBusiness = businesses[0]
        
        for business in businesses {
            if business.rating > currentHighestRatedBusiness.rating {
                currentHighestRatedBusiness = business
            }
        }
        
        return currentHighestRatedBusiness.id
    }
}
