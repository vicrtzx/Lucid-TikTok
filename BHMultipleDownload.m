#import "BHMultipleDownload.h"

@implementation BHMultipleDownload {
    NSMutableArray<NSURL *> *_downloadedFilePaths;
    NSInteger _completedDownloads;
    NSInteger _totalDownloads;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

- (void)downloadFiles:(NSArray<NSURL *> *)fileURLs {
    _downloadedFilePaths = [NSMutableArray array];
    _completedDownloads = 0;
    _totalDownloads = fileURLs.count;

    for (NSURL *fileURL in fileURLs) {
        NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:fileURL];
        [downloadTask resume];
    }

    if (fileURLs.count == 0) {
        [self URLSession:self.session didBecomeInvalidWithError:[NSError errorWithDomain:NSURLErrorDomain code:99 userInfo:nil]];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float prog = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    if ([self.delegate respondsToSelector:@selector(downloaderProgress:)]) {
        [self.delegate downloaderProgress:prog];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
  didFinishDownloadingToURL:(NSURL *)location {
    NSString *tempPath = NSTemporaryDirectory();
    NSString *destinationPath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", NSUUID.UUID.UUIDString, downloadTask.response.suggestedFilename ?: @"video.mp4"]];
    
    NSError *error;
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:destinationPath] error:&error];
    
    if (error == nil) {
        [_downloadedFilePaths addObject:[NSURL fileURLWithPath:destinationPath]];
    }
    
    _completedDownloads++;
    
    if (_completedDownloads == _totalDownloads) {
        if ([self.delegate respondsToSelector:@selector(downloaderDidFinishDownloadingAllFiles:)]) {
            [self.delegate downloaderDidFinishDownloadingAllFiles:_downloadedFilePaths];
        }
        [self.session finishTasksAndInvalidate];
    }
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(downloaderDidFailureWithError:)]) {
        [self.delegate downloaderDidFailureWithError:error];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        if ([self.delegate respondsToSelector:@selector(downloaderDidFailureWithError:)]) {
            [self.delegate downloaderDidFailureWithError:error];
        }
        [self.session finishTasksAndInvalidate];
    }
}

@end
