//
//  Home.swift
//  GYMTrack
//
//  Created by Metehan Özden on 18.11.2024.
//

import SwiftUI

struct HomeView: View {
    @State var currentDate : Date = .init()
    @State private var weekSlider : [[Date.WeekDay]] = []
    @State private var currentWeekIndex : Int = 1
    @State private var createWeek = false
    @State private var workout: [Workout] = sampleWorkout

    @Namespace private var animation
    var body: some View {
        VStack(alignment: .leading,spacing: 0, content: {
            headerView()
            ExercisesRowViewBuilder()
        })
        .vSpacing(.top)
        .onAppear {
            if weekSlider.isEmpty{
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date{
                    weekSlider.append(firstDate.createPrevWeek())
                }
                 
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date{
                    weekSlider.append(lastDate.createNextWeek())

                }
            }
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        VStack(alignment: .leading, spacing: 6 ){
            HStack {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.projectRed)
                Text(currentDate.format("dd"))
            }.font(.title.bold())
            
            TabView(selection: $currentWeekIndex){
                
                ForEach(weekSlider.indices, id: \.self){index in
                    let week = weekSlider[index]
                    weekView(week)
                        .tag(index)
                }
                
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 90)
                .offset(y:10)
            
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing, content: {
            ZStack {
                Image("flame")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                Text("68")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .offset(y:8)
            }
            .offset(y:-10)

        })
        .padding(15)
        .background(.white)
        .onChange(of: currentWeekIndex, initial: false){ oldValue, newValue in
            if newValue == 0 || newValue == (weekSlider.count - 1){
                createWeek = true
            }
        }
    }
    
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0){
            ForEach(week){ day in
                VStack(spacing: 8){
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .projectColdSand: .projectRed)
                        .frame(width: 35, height: 35)
                        .background(content: {
                            if day.date.isToday{
                                
                                Circle().fill(.projectColdSand)
                                    .vSpacing(.bottom)

                                /*
                                Circle().fill(.projectRed)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 11)
                                 */
                            }
                            
                            if isSameDate(day.date, currentDate){
                                Circle().fill(.projectRed)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            

                        })
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                    
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy){
                        currentDate = day.date
                    }
                }
            }
        }.background{
            GeometryReader{
                let minX = $0.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self){ value in
                        if value.rounded() == 15 && createWeek{
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }

    }
    
    @ViewBuilder
    func ExercisesRowViewBuilder() -> some View {

        WorkoutRowView(workouts: $workout)

    }

    
    func paginateWeek(){
        if weekSlider.indices.contains(currentWeekIndex ){
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0{
                weekSlider.insert(firstDate.createPrevWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1){
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
                
            }
        }
    }

}

#Preview {
    ContentView()
}
