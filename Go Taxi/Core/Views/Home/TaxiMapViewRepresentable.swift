//
//  TaxiMapViewRepresentable.swift
//  Go Taxi
//
//  Created by apple on 09.08.2023.
//

import SwiftUI
import MapKit

struct TaxiMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    //make maoView
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate {
            print("DEBAG: Selected lcation in map view \(coordinate)")
        }
    }
    
    // make coordinates
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(perent: self)
    }
}

extension TaxiMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let perent: TaxiMapViewRepresentable
        
        init(perent: TaxiMapViewRepresentable) {
            self.perent = perent
            super.init()
        }
        
        //update user coordinates
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            perent.mapView.setRegion(region, animated: true)
        }
    }
}
