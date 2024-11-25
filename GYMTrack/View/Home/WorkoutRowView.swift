//
//  WorkoutRowView.swift
//  GYMTrack
//
//  Created by Metehan Özden on 19.11.2024.
//

import SwiftUI

struct WorkoutRowView: View {
    @Binding var workouts: [Workout]

    var body: some View {
        /*
        List {
            Section(header: Text(workout.name)) {
                ForEach($workout.exercises) { $exercise in
                    HStack {
                        Image(exercise.muscle.description)
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(exercise.name)
                            .font(.headline)
                        Spacer()
                        Text("\(exercise.sets)x\(exercise.reps)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }*/
        
        List {
            ForEach(workouts) { workout in
                Section(header: HStack{
                    Image(workout.icon)
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text(workout.name)
                        .font(.headline)
                }    .padding(.horizontal, 10)
                    .padding(.vertical, 5)

                    .background(.white.shadow(.drop(radius: 1)), in: .capsule)
                ) {
                    ForEach(workout.exercises) { exercise in
                        HStack {
                            Image(exercise.muscle.description)
                                .resizable()
                                .frame(width: 40, height: 40)

                            Text(exercise.name)
                                .font(.headline)
                            Spacer()
                            Text("\(exercise.muscle.description.capitalized) - \(exercise.sets)x\(exercise.reps)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    ContentView()
}


