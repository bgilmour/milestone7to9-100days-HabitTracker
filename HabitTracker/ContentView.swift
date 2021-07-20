//
//  ContentView.swift
//  HabitTracker
//
//  Created by Bruce Gilmour on 2021-07-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false

    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items.indices, id: \.self) { index in
                    NavigationLink(destination: ActivityView(item: $activities.items[index])) {
                        ActivityRowView(item: activities.items[index])
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("HabitTracker")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        showingAddActivity = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddActivity) {
                AddActivity(activities: activities)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
