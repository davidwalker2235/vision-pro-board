import SwiftUI
import RealityKit

extension Entity {
    /// Resets all the elements of a trace.
    func resetTrace(recursive: Bool = false) {
        if recursive {
            for child in children {
                child.resetTrace(recursive: recursive)
            }
        }
    }
}
