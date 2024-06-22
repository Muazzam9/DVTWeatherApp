//
//  CitiesListView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/21.
//

import SwiftUI
import CoreLocation

struct CitiesListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DataStore.self) private var store
    @State var selectedCity: City?
    @State private var isSearching = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search...", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .focused($isFocused)
                    }
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            isSearching.toggle()
                        }
                    }
                    List {
                        Group {
                            ForEach(store.cities.sorted(using: KeyPathComparator(\.name))) { city in
                                CityRowView(viewModel: SavedLocationViewModel(savedLocation: CLLocation(latitude: city.latitude, longitude: city.longitude)), city: city)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            if let index = store.cities.firstIndex(where: {$0.id == city.id}) {
                                                store.cities.remove(at: index)
                                                store.saveCities()
                                            }
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .onTapGesture {
                                        selectedCity = city
                                        dismiss()
                                    }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .listRowInsets(.init(top: 0, leading: 20, bottom: 5, trailing: 20))
                    }
                    .listStyle(.plain)
                    .navigationTitle("My Cities")
                    .navigationBarTitleDisplayMode(.inline)
                    .preferredColorScheme(.dark)
                }
                if isSearching {
                    SearchOverlay(isSearching: $isSearching)
                        .zIndex(1.0)
                }
            }
        }
    }
}
