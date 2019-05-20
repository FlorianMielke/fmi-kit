#import "FakeTableViewDataSource.h"

@implementation FakeTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
  }
  NSString *textLabelText = [NSString stringWithFormat:@"%li - %li", (long)[indexPath section], (long)[indexPath row]];
  [[cell textLabel] setText:textLabelText];
  return cell;
}

@end
