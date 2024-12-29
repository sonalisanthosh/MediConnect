//
//  HomeView.swift
//  MediConnect
//
//  Created by Sonali Santhosh on 12/27/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedQuickAction: String? = nil
    @State private var showNotifications = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                VStack(alignment: .leading) {
                    Text("Hello, Sonali")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Your health dashboard")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    showNotifications.toggle()
                }) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            
            // User Stats Section
            HStack(spacing: 15) {
                StatCard(title: "Steps", value: "8,432", icon: "figure.walk", color: .green)
                StatCard(title: "Heart Rate", value: "72 BPM", icon: "heart.fill", color: .red)
                StatCard(title: "Sleep", value: "7h 45m", icon: "bed.double.fill", color: .blue)
            }
            .padding(.horizontal)
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search for services or specialists", text: $searchText)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
            
            // Quick Actions Section
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                QuickActionCard(title: "Appointments", icon: "calendar", color: Color.blue.opacity(0.8))
                    .onTapGesture { selectedQuickAction = "appointments" }
                QuickActionCard(title: "Records", icon: "doc.text", color: Color.purple.opacity(0.8))
                    .onTapGesture { selectedQuickAction = "records" }
                QuickActionCard(title: "Lab Results", icon: "cross.case", color: Color.green.opacity(0.8))
                    .onTapGesture { selectedQuickAction = "labs" }
                          }
                          .padding(.horizontal)
                }
        VStack {
            Button(action: {
                // Add your action for the "Ask AI" button here
                print("Ask AI button tapped")
                // Navigate to the "Ask AI" view or trigger AI logic
            }) {
                HStack {
                    Image(systemName: "brain")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.083, green: 0.151, blue: 0.325))
                    Text("Ask AI")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal)
        }
        
        // Recent Activities
        VStack(alignment: .leading, spacing: 15) {
            Text("Your Recent Activity")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ForEach(0..<3) { index in
                ActivityCard()
                    .onTapGesture {
                        // Handle activity selection
                    }
            }
        }
        
        Spacer()
    }
        .padding(.top, 20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.05, green: 0.1, blue: 0.2), Color(red: 0.1, green: 0.15, blue: 0.4)]),
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 120, height: 120)
        .background(Color.white.opacity(0.2))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct ActivityCard: View {
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "stethoscope")
                        .foregroundColor(.blue)
                )

            VStack(alignment: .leading, spacing: 5) {
                Text("Doctor Appointment")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Tomorrow at 10:00 AM")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 100)
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
