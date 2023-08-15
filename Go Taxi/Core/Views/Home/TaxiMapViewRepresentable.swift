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
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
        }
    }
    
    // make coordinates
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(perent: self)
    }
}
//MARK: - Extansion
extension TaxiMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        //MARK: - Properties
        let perent: TaxiMapViewRepresentable
        
        //MARK: - Lifecycle
        init(perent: TaxiMapViewRepresentable) {
            self.perent = perent
            super.init()
        }
        
        //MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            perent.mapView.setRegion(region, animated: true)
        }
        
        //MARK: - Helpers
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            perent.mapView.removeAnnotations(perent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            perent.mapView.addAnnotation(anno)
            perent.mapView.selectAnnotation(anno, animated: true)
            
            perent.mapView.showAnnotations(perent.mapView.annotations, animated: true)
        }
    }
}
