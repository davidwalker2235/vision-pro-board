import SwiftUI

@Observable
class ViewModel {
    
    var navigationPath: [Module] = []
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Patien"

    var isShowingBone: Bool = false
    var bone: RadiographyEntity.Configuration = .boneDefault
    var isBoneRotating: Bool = false
}
