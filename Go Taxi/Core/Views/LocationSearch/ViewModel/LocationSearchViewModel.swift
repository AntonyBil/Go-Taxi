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
    
}
//MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
