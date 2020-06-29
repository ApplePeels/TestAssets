


#import "image.h"

@implementation Image

+ (UIImage*)getImage:(NSString*)imageName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"TestFlutter" withExtension:@"bundle"];
    UIImage * image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleWithURL:url] compatibleWithTraitCollection:nil];

    return image;
}


+ (UIImage *)sc_imageNamed:(NSString *)imageName {
    NSArray *symbols = [NSThread callStackSymbols];
    
    if (symbols.count > 1) {
        
        NSArray *subSymbols = [symbols[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
        
        if (subSymbols.count > 1) {
            
            NSArray *callerSymbols = [subSymbols[1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            
            NSBundle *currentBundle = [NSBundle bundleForClass:NSClassFromString(callerSymbols.firstObject)];
            return [UIImage imageNamed:imageName inBundle:currentBundle compatibleWithTraitCollection:nil];
        }
    }
    return [UIImage imageNamed:imageName?:@""];
}

+ (UIImage *)sc_imageNamed:(NSString *)imageName context:(Class)cls {
    NSBundle *currentBundle = [NSBundle bundleForClass:cls];
    return [UIImage imageNamed:imageName inBundle:currentBundle?:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
}
@end
