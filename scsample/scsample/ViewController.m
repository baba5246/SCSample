
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SCAPI.h"

@interface ViewController ()
{
    AVAudioPlayer *player;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat cumulo_height = self.view.frame.size.height - 150;
    
    UIButton *play = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [play setFrame:CGRectMake(20, cumulo_height, self.view.frame.size.width-40, 30)];
    [play setTitle:@"Play" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playSong) forControlEvents:UIControlEventTouchUpInside];
    
    cumulo_height += play.frame.size.height + 10;
    
    UIButton *pause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pause setFrame:CGRectMake(20, cumulo_height, self.view.frame.size.width-40, 30)];
    [pause setTitle:@"Pause" forState:UIControlStateNormal];
    [pause addTarget:self action:@selector(pauseSong) forControlEvents:UIControlEventTouchUpInside];
    
    cumulo_height += pause.frame.size.height + 10;
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stop setFrame:CGRectMake(20, cumulo_height, self.view.frame.size.width-40, 30)];
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopSong) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:play];
    [self.view addSubview:pause];
    [self.view addSubview:stop];
    
}

- (void) playSong
{
    // 時間計測開始
    NSDate *started = [NSDate date];
    
    // URL指定
    NSString *apiUrl = @"https://api.soundcloud.com/tracks/%@/stream?client_id=%@";
    NSString *songId = @"13678407";
    NSString *clientId = @"e1473e819ae2406e130bdff0c8087e7f";
    
    // Request
    NSString *urlString = [NSString stringWithFormat:apiUrl, songId, clientId];
    [SCRequest performMethod: SCRequestMethodGET
                  onResource: [NSURL URLWithString:urlString]
             usingParameters: nil
                 withAccount: nil
      sendingProgressHandler: nil
             responseHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                 
                 player = [[AVAudioPlayer alloc] initWithData:data error:nil];
                 player.volume = 0.7;
                 player.currentTime = 0;
                 [player prepareToPlay];
                 [player play];
                 
                 // 計測時間
                 NSTimeInterval elapsed = [started timeIntervalSinceNow];
                 NSLog(@"Elapsed: %.2fs", elapsed);
             }];
    
}

- (void) pauseSong
{
    if (player != nil && player.isPlaying) {
        [player pause];
    }
}

- (void) stopSong
{
    if (player != nil) {
        [player stop];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
