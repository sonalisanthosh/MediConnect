//
//  HomeView.swift
//  MediConnect
//
//  Created by Sonali Santhosh on 12/27/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
    var body: some View {
        
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Medical Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "bell")
                    .font(.title2)
            }
            .padding()
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Quick Actions
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    QuickActionCard(title: "Upcoming\nAppointments", icon: "calendar", color: .blue)
                    QuickActionCard(title: "Medical\nRecords", icon: "doc.text", color: .purple)
                    QuickActionCard(title: "Lab\nResults", icon: "cross.case", color: .green)
                }
                .padding(.horizontal)
            }
            
            // Recent Activities
            VStack(alignment: .leading, spacing: 15) {
                Text("Recent Activities")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(0..<3) { _ in
                    ActivityCard()
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            Text(title)
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(width: 100, height: 100)
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

struct ActivityCard: View {
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "stethoscope")
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading) {
                Text("Doctor Appointment")
                    .fontWeight(.semibold)
                Text("Scheduled for tomorrow")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
