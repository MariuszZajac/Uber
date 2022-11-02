//
//  RideRequestView.swift
//  Uber
//
//  Created by Mariusz Zając on 02/11/2022.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
            // trip info
            HStack{
                // indicator view
                VStack{
                Circle()
                    .fill(Color(.systemGray3))
                    .frame(width: 8, height: 8)
                
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: 1, height: 32)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 8, height: 8)
            }
                VStack(alignment: .leading, spacing: 24){
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")//TODO update timer
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    HStack{
                        Text("Destination")
                            .font(.system(size: 16, weight: .semibold))
                            
                        Spacer()
                        Text("1:35 PM")//TODO update timer
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }.padding(.leading, 8)
            }.padding()
            Divider()
            
            // ride type select
            Text("SUGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(0 ..< 3, id: \.self) { _ in
                        VStack(alignment: .leading) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            VStack(spacing: 4){
                                Text("UberX")
                                    .font(.system(size: 14, weight: .semibold))
                                   
                                
                                Text("$ 12,78")
                                    .font(.system(size: 14, weight: .semibold))
                                   
                            }.padding(8)
                            
                        }
                        .frame(width: 122, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                    
                    }
                }
            }.padding(.horizontal)
            Divider()
                .padding(.vertical, 8)
            // payment
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            // request button
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32 ,height: 50)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
        .background(.white)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
