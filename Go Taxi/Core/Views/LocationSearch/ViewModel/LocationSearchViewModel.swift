//
//  LocationSearchViewModel.swift
//  Go Taxi
//
//  Created by apple on 14.08.2023.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: String?
    
    private let searchCoompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            print("DEBUG: Query frugment is \(queryFragment)")
            searchCoompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCoompleter.delegate = self
        searchCoompleter.queryFragment = queryFragment
    }
    
    //MARK: - Helpers
    func selectLocation(_ location: String) {
        self.selectedLocation = location
        
        print("DEBUG: Selected location is \(self.selectedLocation)")
    }
}
//MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
