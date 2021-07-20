//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Bruce Gilmour on 2021-07-18.
//

import SwiftUI

struct ActivityView: View {
    @Binding var item: Activity

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text(item.description)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.top, .bottom])
                VStack(alignment: .center) {
                    Button(action: {
                        item.occurrences += 1
                    }) {
                        if item.goodHabit {
                            Text("Good job!")
                                .foregroundColor(.green)
                        } else {
                            Text("Oops, I did it again!")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text("\(item.name) (\(item.categoryName))"), displayMode: .inline)
    }
}

struct ActivityView_Previews: PreviewProvider {
    @State static var example = Activity.example1

    static var previews: some View {
        ActivityView(item: $example)
    }
}
