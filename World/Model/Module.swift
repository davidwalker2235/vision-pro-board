import Foundation

enum Module: String, Identifiable, CaseIterable, Equatable {
    case report, radiography, drugs
    var id: Self { self }
    var name: String { rawValue.capitalized }

    var eyebrow: String {
        switch self {
        case .report:
            "Medical Report"
        case .radiography:
            "Analisys"
        case .drugs:
            "Drugs"
        }
    }

    var heading: String {
        switch self {
        case .report:
            "Medical History"
        case .radiography:
            "Radiography"
        case .drugs:
            "Drugs list"
        }
    }

    var abstract: String {
        switch self {
        case .report:
            "A lot goes into making a day happen on Planet Earth! Discover how our globe turns and tilts to give us hot summer days, chilly autumn nights, and more."
        case .radiography:
            "Radiografía en 3 dimensiones para un análisis visual y exhaustivo para detectar roturas o anomalías."
        case .drugs:
            "Selects the drugs that should be prescribed to the patient"
        }
    }

    var overview: String {
        switch self {
        case .report:
            "Name: David Carmona Age: 34 years old Sex: Male Reason for consultation: Persistent abdominal pain, nausea and loss of appetite. Personal history: Occasional smoker, moderate drinker, allergic to pollen and peanuts. Family history: Father died of colon cancer, mother with high blood pressure, sister with type 2 diabetes. Physical examination: Abdomen distended and painful to palpation, especially in the lower right quadrant. No signs of peritonitis. Pulse: 80 beats per minute. Blood pressure: 130/85 mmHg. Temperature: 36.5°C. Complementary tests: Blood, urine and stool analysis, abdominal ultrasound and colonoscopy are requested."
        case .radiography:
            "Patient name: David Carmona Age: 51 years Sex: Male Reason for consultation: Pain and swelling in the left arm History: The patient suffered a fall from a ladder while painting his house two days ago. He did not go to the doctor immediately, but applied ice and took painkillers. However, the pain and swelling did not improve, and the patient noticed a deformity in the arm. Physical examination: The patient has a closed fracture of the diaphysis of the left humerus, with displacement and angulation of the bone fragments. A bruise is observed in the elbow region and a limitation of the mobility of the arm. The patient reports intense pain to the touch and passive mobilization. No signs of vascular or nervous compromise are evident. Complementary tests: An X-ray of the left arm was performed, which confirmed the fracture and showed the degree of displacement and angulation of the fragments. "
        case .drugs:
            ""
        }
    }

    var callToAction: String {
        switch self {
        case .report: "View Report"
        case .radiography: "View Radiography"
        case .drugs: ""
        }
    }

    static let funFacts = [""]
}
