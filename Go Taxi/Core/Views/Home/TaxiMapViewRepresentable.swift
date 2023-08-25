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
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
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
        
        switch mapState {
        case .noInput:
            context.coordinator.clearmapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        }
        
//        if mapState == .noInput {
//            context.coordinator.clearmapViewAndRecenterOnUserLocation()
//        }
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
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        //MARK: - Lifecycle
        init(perent: TaxiMapViewRepresentable) {
            self.perent = perent
            super.init()
        }
        
        //MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            self.currentRegion = region
            
            perent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        //MARK: - Helpers
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            perent.mapView.removeAnnotations(perent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            perent.mapView.addAnnotation(anno)
            perent.mapView.selectAnnotation(anno, animated: true)
            
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            perent.locationViewModel.getDestinationRoute(from: userLocationCoordinate,
                                                         to: coordinate) { route in
                self.perent.mapView.addOverlay(route.polyline)
                let rect = self.perent.mapView.mapRectThatFits(route.polyline.boundingMapRect,
                                                               edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.perent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func clearmapViewAndRecenterOnUserLocation() {
            perent.mapView.removeAnnotations(perent.mapView.annotations)
            perent.mapView.removeOverlays(perent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                perent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
