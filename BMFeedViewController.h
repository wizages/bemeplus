@interface BMFeedViewController : NSObject

-(id) currentPlayingStack ;

/*
* This is a new fuction that will convert the video from .ts to .mov
*/
-(void) convertVideo: (NSString *) fileName;

-(void) importToPhotoAlbum: (NSString *) fileName;


@end

@interface BMUserModel : NSObject

@property(copy) NSString * displayName;

@end

@interface BMStackModel : NSObject

@property(copy) NSURL * streamURL;
@property(copy) BMUserModel * user;
@property(assign) NSInteger * identifier;

@end