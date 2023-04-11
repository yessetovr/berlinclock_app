import SwiftUI

struct BerlinClockView: View {
    
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select a time", selection: $selectedDate, displayedComponents: [.hourAndMinute])
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
            
            Spacer()
            
            BerlinClock(time: selectedDate)
            
            Spacer()
        }
    }
}

struct BerlinClock: View {
    
    let time: Date
    
    var body: some View {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: time)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        VStack(spacing: 10) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 5)
//                    .fill(Color.black)
                HStack(spacing: 5) {
                    Text(seconds % 2 == 0 ? "🔴" : "⚪️")
                        .font(.system(size: 20))
                    ForEach(0..<4) { index in
                        Text(index < hours / 5 ? "🔴" : "⚪️")
                            .font(.system(size: 20))
                    }
                }
//            }
            
            HStack(spacing: 5) {
                ForEach(0..<4) { index in
                    Text(index < hours % 5 ? "🟡" : "⚪️")
                        .font(.system(size: 20))
                }
            }
            
            HStack(spacing: 5) {
                ForEach(0..<11) { index in
                    if index == 2 || index == 5 || index == 8 {
                        Text(index < minutes / 5 ? "🔴" : "⚪️")
                            .font(.system(size: 20))
                    } else {
                        Text(index < minutes % 5 ? "🟡" : "⚪️")
                            .font(.system(size: 20))
                    }
                }
            }
        }
    }
}

struct BerlinClockView_Previews: PreviewProvider {
    static var previews: some View {
        BerlinClockView()
    }
}
