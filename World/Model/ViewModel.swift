import SwiftUI

@Observable
class ViewModel {
    
    var navigationPath: [Module] = []
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Patien"

    var isShowingGlobe: Bool = false
    var globeEarth: EarthEntity.Configuration = .globeEarthDefault
    var isGlobeRotating: Bool = false
}
