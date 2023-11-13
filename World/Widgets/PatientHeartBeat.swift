import SwiftUI
import Charts

struct PatientHeartBeat: View {
    @State private var data = HealthData.ecgSample
    @State private var lineWidth = 4.0
    @State private var chartColor: Color = .red
    
    var body: some View {
        chartAndLabels
    }
    
    private var chartAndLabels: some View {
        let timer = Timer.publish(every: 0.0000001, on: .main, in: .common).autoconnect()
        
        return VStack(alignment: .leading) {
            Text("Sinus Rhythm")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
            Group {
                Text(Date(), style: .date) +
                Text(" at ") +
                Text(Date(), style: .time)
            }
            .foregroundColor(.secondary)
            chart
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
                Text("68 BPM Average")
                    .foregroundColor(.secondary)
            }
        }
        .onReceive(timer) { _ in
            data.append(data.first!)
            data.removeFirst()
        }
        .frame(height: Constants.detailChartHeight)
    }
    
    private var chart: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.element) { index, element in
                LineMark(
                    x: .value("Seconds", Double(index)/400.0),
                    y: .value("Unit", element)
                )
                .lineStyle(StrokeStyle(lineWidth: lineWidth))
                .foregroundStyle(chartColor)
                .accessibilityLabel("\(index)s")
                .accessibilityValue("\(element) mV")
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 12)) { value in
                if let doubleValue = value.as(Double.self),
                   let intValue = value.as(Int.self) {
                    if doubleValue - Double(intValue) == 0 {
                        AxisTick(stroke: .init(lineWidth: 1))
                            .foregroundStyle(.white)
                        AxisValueLabel() {
                            Text("\(intValue)s")
                        }
                        AxisGridLine(stroke: .init(lineWidth: 1))
                            .foregroundStyle(.white)
                    } else {
                        AxisGridLine(stroke: .init(lineWidth: 1))
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .chartYScale(domain: -400...800)
        .chartYAxis {
            AxisMarks(values: .automatic(desiredCount: 14)) { value in
                AxisGridLine(stroke: .init(lineWidth: 1))
                    .foregroundStyle(.white)
            }
        }
        .chartPlotStyle {
            $0.border(Color.gray)
        }
    }
}

#Preview {
    PatientHeartBeat()
}
