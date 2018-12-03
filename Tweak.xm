@interface SBFolderBackgroundView : UIView
@end

@interface SBFolderControllerBackgroundView : UIView {
    UIVisualEffectView* _blurView;
}
@end

@interface SBFolderTitleTextField : UITextField
@end

@interface SBFloatingDockPlatterView : UIView
- (UIView*)backgroundView;
@end

@interface CALayer (ContinuousCorners)
- (void)setContinuousCorners:(BOOL)arg1;
@end

UIVisualEffectView* folderBackgroundView;
UIVisualEffectView* textFieldBackgroundView;
UIVisualEffectView* dockBackgroundView;



%hook SBFolderBackgroundView

- (id)initWithFrame:(CGRect)arg1 {
    id r = %orig;
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    folderBackgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self addSubview:folderBackgroundView];
    
    return r;
}

- (void)layoutSubviews {
    %orig;
    [folderBackgroundView setFrame:self.bounds];
}

%end    // %hook SBFolderBackgroundView



%hook SBFolderControllerBackgroundView

- (id)initWithFrame:(CGRect)arg1 {
    id r = %orig;
    
    MSHookIvar<UIVisualEffectView*>(self, "_blurView") = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    return r;
}

- (void)layoutSubviews {
    %orig;
//    [MSHookIvar<UIVisualEffectView*>(self, "_blurView") setHidden:YES];
}

%end    // %hook SBFolderControllerBackgroundView


// Some code for a dark mode I was working on, but I quickly scrapped it

//%hook SBFolderTitleTextField
//
//- (id)initWithFrame:(CGRect)arg1 {
//    id r = %orig;
//    
//    textFieldBackgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
//    [textFieldBackgroundView setClipsToBounds:YES];
//    [textFieldBackgroundView.layer setCornerRadius:9];
//    [self insertSubview:textFieldBackgroundView atIndex:0];
//    
//    return r;
//}
//
//- (void)layoutSubviews {
//    %orig;
//    [textFieldBackgroundView setFrame:self.bounds];
//}
//
//- (void)setBackground:(id)arg1 {
//    %orig(nil);
//}
//
//- (id)background {
//    return nil;
//}
//
//%end    // %hook SBFolderTitleTextField
//
//
//
//%hook SBFloatingDockPlatterView
//
//- (id)initWithFrame:(CGRect)arg1 {
//    id r = %orig;
//    
//    dockBackgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
//    [dockBackgroundView.layer setCornerRadius:29];
//    [dockBackgroundView.layer setContinuousCorners:YES];
//    [dockBackgroundView setClipsToBounds:YES];
//    [self insertSubview:dockBackgroundView atIndex:0];
//    [[self backgroundView] setHidden:YES];
//    
//    return r;
//}
//
//- (void)layoutSubviews {
//    %orig;
//    [[self backgroundView] setHidden:YES];
//    [dockBackgroundView setFrame:[[self backgroundView] frame]];
//}
//
//%end    // SBFloatingDockPlatterView
