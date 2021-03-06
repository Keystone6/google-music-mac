/*
 * ApplicationStyle.m
 *
 * Created by Sajid Anwar.
 *
 * Subject to terms and conditions in LICENSE.md.
 *
 */

#import "ApplicationStyle.h"

@implementation ApplicationStyle

@synthesize name;
@synthesize author;
@synthesize description;
@synthesize version;

@synthesize css;
@synthesize js;

- (void)applyToWebView:(id)webView
{
    // Setup the CSS.
    NSString *cssBootstrap = @"Styles.applyStyle(\"%@\", \"%@\");";
    NSString *cssFinal = [NSString stringWithFormat:cssBootstrap, [self name], [self css]];
    
    [webView stringByEvaluatingJavaScriptFromString:cssFinal];
    [webView stringByEvaluatingJavaScriptFromString:[self js]];
}

+ (NSString *)cssNamed:(NSString *)name
{
    NSString *file = [NSString stringWithFormat:@"css/%@", name];
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"css"];
    NSString *css = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    css = [css stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    css = [css stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    return css;
}

+ (NSString *)jsNamed:(NSString *)name
{
    NSString *file = [NSString stringWithFormat:@"js/%@", name];
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    return js;
}

+ (NSMutableDictionary *)styles
{
    // Create the Cocoa style.
    ApplicationStyle *cocoa = [[ApplicationStyle alloc] init];
    [cocoa setName:@"Cocoa"];
    [cocoa setAuthor:@"Sajid Anwar"];
    [cocoa setDescription:@"An application style to match Mac OS X."];
    [cocoa setWindowColor:[NSColor colorWithSRGBRed:0.898f green:0.898f blue:0.898f alpha:1.0f]];
    [cocoa setCss:[ApplicationStyle cssNamed:@"cocoa"]];
    [cocoa setJs:nil];
    
    // Create the Dark style.
    ApplicationStyle *dark = [[ApplicationStyle alloc] init];
    [dark setName:@"Dark"];
    [dark setAuthor:@"Sajid Anwar"];
    [dark setDescription:@"A dark style similar to Spotify."];
    [dark setWindowColor:[NSColor colorWithSRGBRed:0.768f green:0.768f blue:0.768f alpha:1.0f]];
    [dark setCss:[ApplicationStyle cssNamed:@"dark"]];
    [dark setJs:nil];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:cocoa forKey:[cocoa name]];
    [dictionary setObject:dark forKey:[dark name]];
    
    return dictionary;
}

@end
