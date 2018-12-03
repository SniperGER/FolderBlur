@interface SBFolderBackgroundView : UIView {
    UIVisualEffectView* _blurView;
}
@end



%hook SBFolderBackgroundView

- (id)initWithFrame:(CGRect)arg1 {
    id r = %orig;
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIVisualEffectView* folderBackgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    MSHookIvar<UIVisualEffectView*>(self, "_blurView") = folderBackgroundView;
    
    [self addSubview:folderBackgroundView];
    
    return r;
}

- (void)layoutSubviews {
    %orig;
    [MSHookIvar<UIVisualEffectView*>(self, "_blurView") setFrame:self.bounds];
}

%end    // %hook SBFolderBackgroundView
