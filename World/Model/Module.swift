/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The modules that the app can present.
*/


import Foundation

/// A description of the modules that the app can present.
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
            "Get up close with different types of orbits to learn more about how satellites and other objects move in space relative to the Earth."
        case .drugs:
            "Take a trip to the solar system and watch how the Earth, Moon, and its satellites are in constant motion rotating around the Sun."
        }
    }

    var overview: String {
        switch self {
        case .report:
            "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."
        case .radiography:
            "Patient name: David Carmona Age: 51 years Sex: Male Reason for consultation: Pain and swelling in the left arm History: The patient suffered a fall from a ladder while painting his house two days ago. He did not go to the doctor immediately, but applied ice and took painkillers. However, the pain and swelling did not improve, and the patient noticed a deformity in the arm. Physical examination: The patient has a closed fracture of the diaphysis of the left humerus, with displacement and angulation of the bone fragments. A bruise is observed in the elbow region and a limitation of the mobility of the arm. The patient reports intense pain to the touch and passive mobilization. No signs of vascular or nervous compromise are evident. Complementary tests: An X-ray of the left arm was performed, which confirmed the fracture and showed the degree of displacement and angulation of the fragments. "
        case .drugs:
            "Every 365¼ days, Earth and its satellites completely orbit the Sun — the star that anchors our solar system. It’s a journey of about 940 million kilometers a year!\n\nOn its journey, the Earth moves counter-clockwise in a slightly elliptical orbit. It travels a path called the ecliptic plane — an important part of how we navigate through our solar system.\n\nWant to explore Earth’s orbit in detail? Take a trip to the solar system and watch how Earth and its satellites move around the Sun."
        }
    }

    var callToAction: String {
        switch self {
        case .report: "View Bone"
        case .radiography: "View Orbits"
        case .drugs: "View Outer Space"
        }
    }

    static let funFacts = [
        "The Earth orbits the Sun on an invisible path called the ecliptic plane.",
        "All planets in the solar system orbit within 3°–7° of this plane.",
        "As the Earth orbits the Sun, its axial tilt exposes one hemisphere to more sunlight for half of the year.",
        "Earth's axial tilt is why different hemispheres experience different seasons."
    ]
}
