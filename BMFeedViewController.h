@interface BMFeedViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) UITableView *tableView;

- (id)currentPlayingStack;
- (void)playVideoFromCellAtIndexPath:(NSIndexPath *)indexPath;

/*
* This is a new fuction that will convert the video from .ts to .mov
*/
- (void)convertVideo:(NSString *)fileName;
- (void)importToPhotoAlbum:(NSString *)fileName;
- (void)bmp_setupToolbar;
- (void)bmp_createNewUpload;
- (void)bmp_openSavedVault;
@end

@interface BMUserModel : NSObject
@property(copy) NSString * displayName;
@end

@interface BMStackModel : NSObject
@property (copy) NSURL *streamURL;
@property (copy) BMUserModel *user;
@property (assign) NSInteger *identifier;
@end