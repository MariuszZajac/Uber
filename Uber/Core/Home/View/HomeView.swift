//
//  HomeView.swift
//  Uber
//
//  Created by Mariusz Zając on 01/11/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noImput
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack (alignment: .top){
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState )
                } else  if mapState == .noImput {
                    LocationSearchActivationView()
                        .padding(.top,72)
                        .onTapGesture {
                            withAnimation(.spring())
                            { mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top,4)
            }
            
            if mapState == .locationSelected{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
