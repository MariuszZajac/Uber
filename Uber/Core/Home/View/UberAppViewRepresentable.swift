//
//  UberAppViewRepresentable.swift
//  Uber
//
//  Created by Mariusz Zając on 31/10/2022.
//

import SwiftUI
import MapKit

struct UberAppViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate {
            print("DEBUG: Selected location in map view \(coordinate)")
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
    
}
extension UberAppViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent:UberAppViewRepresentable
        
        init(parent: UberAppViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 10, //for more accurity set bouth value 0.05  for test =10 TODO
                    longitudeDelta: 10))
            
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
