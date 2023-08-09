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
    
    func makeUIView(context: Context) -> some UIView {
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
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
    }
}
