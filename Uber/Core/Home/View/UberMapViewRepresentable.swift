//
//  UberMapViewRepresentable.swift
//  Uber
//
//  Created by Mariusz Zając on 31/10/2022.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
   // let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noImput:
            context.coordinator.clearMapViewAndRecenterUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
                print("ADDING")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
    
}
extension UberMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        //MARK: -properties
        let parent:UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        //MARK: -Lifecycle
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        //MARK: -MKMapVievDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05, //for more accurity set bouth value 0.05  for test =10 TODO
                    longitudeDelta: 0.05))
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        //MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
        }
        func configurePolyline (withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            parent.locationViewModel.getdestinationRoute(from: userLocationCoordinate,
                                to: coordinate)  { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect,edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        
        func clearMapViewAndRecenterUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
