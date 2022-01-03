//
//  FMIDuration.h
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

import Foundation

extension FMIDuration : ObservableObject {
    
}

extension FMIDuration {
    static func +(lhs: FMIDuration, rhs: FMIDuration) -> FMIDuration {
        FMIDuration(seconds: lhs.seconds + rhs.seconds)
    }
    
    static func -(lhs: FMIDuration, rhs: FMIDuration) -> FMIDuration {
        FMIDuration(seconds: lhs.seconds - rhs.seconds)
    }
}
