//
//  NSData+KJExtension.m
//  KJEmitterView
//
//  Created by yangkejun on 2021/4/28.
//  https://github.com/YangKJ/KJCategories

#import "NSData+KJExtension.h"
#import <zlib.h>

@implementation NSData (KJExtension)

/// Deflate算法压缩
- (NSData *)kj_zipDeflate{
    NSData *data = self;
    if ([data length] == 0) return data;
    
    z_stream strm;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = (int)[data length];
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
    
    do {
        if (strm.total_out >= [compressed length]) {        
            [compressed increaseLengthBy:16384];
        }
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (int)([compressed length] - strm.total_out);
        deflate(&strm, Z_FINISH);
    } while (strm.avail_out == 0);
    deflateEnd(&strm);
    [compressed setLength:strm.total_out];
    
    return [NSData dataWithData:compressed];
}

/// Inflater解压缩，与上面是一对
- (NSData *)kj_zipInflater{
    NSData *data = self;
    if ([data length] == 0) return data;
    unsigned long full_length = (long)[data length];
    unsigned long half_length = [data length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = (int)[data length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    
    while (!done) {
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy:half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (int)([decompressed length] - strm.total_out);
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK) {
            break;
        }
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else {
        return nil;
    }
}

@end
