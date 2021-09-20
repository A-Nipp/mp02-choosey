import Foundation
import SwiftUI

class BusinessListViewModel: ObservableObject {
    @Published var term: String = ""
    @Published var radius: Int = 1
    
    @Published var businesses: [Business] = []
    @Published var highestRatedId: String? = nil
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
  
    func getPlaces() {
        let meters = Measurement(value: Double(radius), unit: UnitLength.miles).converted(to: .meters).value
        isLoading = true
        
        YelpService.getBusinesses(term: term, radius: Int(meters)) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let businesses):
                    self.businesses = businesses
//                    self.highestRatedId = self.getBestRestaurantId(businesses: businesses)
                case .failure(let error):
                    self.errorMessage = error.rawValue
                    self.showError = true
                }
            }
        }
    }
    
    // MARK: Write your function here
}
