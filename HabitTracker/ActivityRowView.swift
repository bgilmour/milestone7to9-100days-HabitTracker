//
//  ActivityRowView.swift
//  HabitTracker
//
//  Created by Bruce Gilmour on 2021-07-17.
//

import SwiftUI

struct ActivityRowView: View {
    let item: Activity

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: item.categoryImage)
                .font(.title2)
                .frame(width: 40)

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)

                Text(item.categoryName)
                    .foregroundColor(item.goodHabit ? .green : .red)
            }

            Spacer()

            Text("\(item.occurrences)")
                .font(.title)
        }
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRowView(item: Activity.example1)
    }
}
