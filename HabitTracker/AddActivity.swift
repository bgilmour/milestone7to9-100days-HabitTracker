//
//  AddActivity.swift
//  HabitTracker
//
//  Created by Bruce Gilmour on 2021-07-17.
//

import SwiftUI

struct AddActivity: View {
    @ObservedObject var activities: Activities
    @State private var name = ""
    @State private var categoryItem = Self.categories[0]
    @State private var description = ""
    @State private var goodHabit = true
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    static let categories: [CategoryItem] = [
        CategoryItem("Communication", "phone"),
        CategoryItem("Cycling", "bicycle"),
        CategoryItem("Exercise", "heart"),
        CategoryItem("Hiking", "figure.walk"),
        CategoryItem("Music", "music.note"),
        CategoryItem("Punctuality", "clock"),
        CategoryItem("Saving", "banknote"),
        CategoryItem("Sleep", "sleep"),
        CategoryItem("Spending", "creditcard")
    ]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Category", selection: $categoryItem) {
                        ForEach(Self.categories, id: \.self) { category in
                            CategoryItemView(item: category)
                        }
                    }
                }
                Section {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.body)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        TextField("Name", text: $name)
                    }
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.body)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        TextEditor(text: $description)
                    }
                    Toggle("Good habit", isOn: $goodHabit)
                }
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                if name.isEmpty || description.isEmpty {
                    showAlert = true
                } else {
                    let categoryName = categoryItem.name
                    let categoryImage = categoryItem.image
                    let item = Activity(id: UUID(), name: name, categoryName: categoryName, categoryImage: categoryImage, description: description, goodHabit: goodHabit, occurrences: 0)
                    activities.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Incomplete activity data"),
                      message: Text("Please enter both a name and a description for the activity"),
                      dismissButton: .default(Text("OK")) { }
                )
            }
        }
    }

    struct CategoryItemView: View {
        let item: CategoryItem

        var body: some View {
            HStack {
                Image(systemName: item.image)
                    .frame(width: 30)
                Text(item.name)
            }
        }
    }

    struct CategoryItem: Hashable {
        let name: String
        let image: String

        init(_ name: String, _ image: String) {
            self.name = name
            self.image = image
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
