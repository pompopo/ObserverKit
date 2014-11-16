#ObserverKit
UIControl, NSNotification, Key Value Observing...

```objectivec

self.ok_observer.control(self.field1, UIControlEventEditingChanged, ^(typeof (self) me, UITextField *field) {
    me.i = [field.text integerValue];

}).control(self.field2, UIControlEventEditingChanged, ^(typeof(self)me, UITextField *field) {
    me.j = [field.text integerValue];

}).keyPath(@[@"i", @"j"], ^(typeof(self)me, id newValue, id oldValue, NSString *path) {
    NSLog(@"%@: %@ -> %@", path, oldValue, newValue);
    me.total = me.i + me.j;

}).keyPath(@"total", ^(typeof(self)me, id val){
    me.resultLabel.text = [NSString stringWithFormat:@"%ld", [val integerValue]];

}).notification(UIApplicationDidReceiveMemoryWarningNotification, ^{
    NSLog(@"Did receive memory warning");
});
```
