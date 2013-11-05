
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SCAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *apiUrl = @"https://api.soundcloud.com/tracks/%@/stream?client_id=%@";
    NSString *songId = @"13678407";
    NSString *clientId = @"e1473e819ae2406e130bdff0c8087e7f";
    
    NSString *urlString = [NSString stringWithFormat:apiUrl, songId, clientId];
    [SCRequest performMethod: SCRequestMethodGET
                  onResource: [NSURL URLWithString:urlString]
             usingParameters: nil
                 withAccount: nil
      sendingProgressHandler: nil
             responseHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                 
                 AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data error:nil];
                 [player prepareToPlay];
                 [player play];
                 NSLog(@"Data duration:%f", player.duration);
             }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
