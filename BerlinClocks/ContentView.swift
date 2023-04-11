//
//  ContentView.swift
//  BerlinClocks
//
//  Created by Райымбек Есетов on 10.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var selectionDate: Date = .distantFuture
    @State var count = 0
    
    var body: some View {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: selectionDate)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
                .opacity(0.12)
            VStack {
                timeIs(selectionDate: $selectionDate)
                    .onReceive(timer, perform: { _ in
                                print("updating")
                                count += 1
                            })
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 358, height: 312)
                        .foregroundColor(.white)
                        .shadow(radius: 14, y: 6).opacity(0.5)
                        .padding(.bottom, 5)
                    VStack {
                        ForEach(0..<1) { index in
                            Circle()
                                .frame(width: 56)
                                .foregroundColor(index < count % 2 ? .yellow : Color(red: 1.0, green: 0.88, blue: 0.6))
                                .padding(.bottom, 8)
                        }
//                        firstRow()
                        HStack {
                            ForEach(0..<4) { index in
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 74, height: 32)
                                    .foregroundColor(index < hours / 5 ? .red : Color(red: 1.0, green: 0.54, blue: 0.51))
                            }
                        }
                            .padding(.bottom, 8)
//                        secondRow()
                        HStack {
                            ForEach(0..<4) { index in
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 74, height: 32)
                                    .foregroundColor(index < hours % 5 ? .red : Color(red: 1.0, green: 0.54, blue: 0.51))
                            }
                        }
                            .padding(.bottom, 8)
//                        thirdRow()
                        HStack(spacing: 8.9) {
                            ForEach(0..<11) { index in
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 21, height: 32)
                                    .foregroundColor(index < minutes / 5 ? .yellow : Color(red: 1.0, green: 0.88, blue: 0.6))
                            }
                        }
                            .padding(.bottom, 8)
//                        fourthRow()
                        HStack {
                            ForEach(0..<4) { index in
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 74, height: 32)
                                    .foregroundColor(index < minutes % 5 ? .yellow : Color(red: 1.0, green: 0.88, blue: 0.6))
                            }
                        }
                            .padding(.bottom, 8)
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(radius: 14, y: 6).opacity(0.5)
                    HStack {
                        Text("Insert time")
                            .font(.system(size: 18, weight: .medium))
                        Spacer()
                        DatePicker("", selection: $selectionDate, displayedComponents: .hourAndMinute)
                            .environment(\.locale, Locale.init(identifier: "ru"))
                            .frame(width: 92)
                            
                    }
                    .padding(.horizontal, 16)
                }
                .frame(width: 358, height: 54)
                Spacer()
            }
        }
    }
}


struct timeIs: View {
    @Binding var selectionDate: Date

    var body: some View {
        Text("Time is \(selectionDate, format: .dateTime.hour().minute())")
            .environment(\.locale, Locale.init(identifier: "ru"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
