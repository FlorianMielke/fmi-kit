//
//  FMIAcceptedCell.h
//
//  Created by Florian Mielke on 30.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIAcceptedCell.h"

@implementation FMIAcceptedCell

- (void)setAccepted:(BOOL)accepted {
    if (_accepted != accepted) {
        _accepted = accepted;
        self.accessoryType = (_accepted) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

@end
