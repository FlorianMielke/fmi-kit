#import "UILabel+StateHandling.h"
#import "UIColor+SystemDefaults.h"

@implementation UILabel (StateHandling)

- (void)fm_markAsActive:(BOOL)active {
  self.textColor = (active) ? self.tintColor : [UIColor cellDefaultStyleDetailLabelColor];
}

- (void)fm_markAsValid:(BOOL)valid {
  NSMutableDictionary *attributes = [[self.attributedText attributesAtIndex:0 effectiveRange:NULL] mutableCopy];
  if (valid) {
    [attributes setValue:@(NSUnderlineStyleNone) forKey:NSStrikethroughStyleAttributeName];
  } else {
    [attributes setValue:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
  }
  self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:[attributes copy]];
}

- (void)fm_setAttributedText:(NSString *)text {
  NSDictionary *attributes = [self.attributedText attributesAtIndex:0 effectiveRange:NULL];
  self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
