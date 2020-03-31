//
//  Created by Florian Mielke on 28.06.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <UIKit/UIKit.h>

#if !defined(FMI_INLINE)
#  if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#    define FMI_INLINE static inline
#  elif defined(__cplusplus)
#    define FMI_INLINE static inline
#  elif defined(__GNUC__)
#    define FMI_INLINE static __inline__
#  else
#    define FMI_INLINE static
#  endif
#endif

#define STRINGIFY2( x) #x
#define STRINGIFY(x) STRINGIFY2(x)

#define FMI_DECODE_OBJ(d,x)  _ ## x = [d decodeObjectForKey:@STRINGIFY(x)]
#define FMI_DECODE_OBJ_DEFAULT(d,x,df) { if ([d containsValueForKey:@STRINGIFY(x)]) { FMI_DECODE_OBJ(d,x); } else { _ ## x = df; } }
#define FMI_ENCODE_OBJ(c,x)  [c encodeObject:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_OBJ_CLASS(d,x,cl)  _ ## x = (cl *)[d decodeObjectOfClass:[cl class] forKey:@STRINGIFY(x)]
#define FMI_DECODE_OBJ_ARRAY(d,x,cl)  _ ## x = (NSArray *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSArray class],[cl class],nil] forKey:@STRINGIFY(x)]
#define FMI_DECODE_OBJ_ARRAY_DEFAULT(d,x,cl,df) { if ([d containsValueForKey:@STRINGIFY(x)]) { FMI_DECODE_OBJ_ARRAY(d,x,cl); }  else { _ ## x = df; } }
#define FMI_DECODE_OBJ_MUTABLE_ORDERED_SET(d,x,cl)  _ ## x = [(NSOrderedSet *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSOrderedSet class],[cl class],nil] forKey:@STRINGIFY(x)] mutableCopy]
#define FMI_DECODE_OBJ_MUTABLE_DICTIONARY(d,x,kcl,cl)  _ ## x = [(NSDictionary *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSDictionary class],[kcl class],[cl class],nil] forKey:@STRINGIFY(x)] mutableCopy]

#define FMI_ENCODE_COND_OBJ(c,x)  [c encodeConditionalObject:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_IMAGE(d,x)  _ ## x = (UIImage *)[d decodeObjectOfClass:[UIImage class] forKey:@STRINGIFY(x)]
#define FMI_ENCODE_IMAGE(c,x)  { if (_ ## x) { UIImage * __ ## x = [UIImage imageWithCGImage:[_ ## x CGImage] scale:[_ ## x scale] orientation:[_ ## x imageOrientation]]; [c encodeObject:__ ## x forKey:@STRINGIFY(x)]; } }

#define FMI_DECODE_BOOL(d,x)  _ ## x = [d decodeBoolForKey:@STRINGIFY(x)]
#define FMI_ENCODE_BOOL(c,x)  [c encodeBool:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_DOUBLE(d,x)  _ ## x = [d decodeDoubleForKey:@STRINGIFY(x)]
#define FMI_DECODE_DOUBLE_DEFAULT(d,x,df) { if ([d containsValueForKey:@STRINGIFY(x)]) { FMI_DECODE_DOUBLE(d,x); } else { _ ## x = df; } }
#define FMI_ENCODE_DOUBLE(c,x)  [c encodeDouble:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_INTEGER(d,x)  _ ## x = [d decodeIntegerForKey:@STRINGIFY(x)]
#define FMI_DECODE_INTEGER_DEFAULT(d,x,df) { if ([d containsValueForKey:@STRINGIFY(x)]) { FMI_DECODE_INTEGER(d,x); } else { _ ## x = df; } }
#define FMI_ENCODE_INTEGER(c,x)  [c encodeInteger:_ ## x forKey:@STRINGIFY(x)]

#define FMI_ENCODE_UINT32(c,x)  [c encodeObject:[NSNumber numberWithUnsignedLongLong:_ ## x] forKey:@STRINGIFY(x)]
#define FMI_DECODE_UINT32(d,x)  _ ## x = (uint32_t)[(NSNumber *)[d decodeObjectForKey:@STRINGIFY(x)] unsignedLongValue]

#define FMI_DECODE_ENUM(d,x)  _ ## x = (__typeof(_ ## x))[d decodeIntegerForKey:@STRINGIFY(x)]
#define FMI_ENCODE_ENUM(c,x)  [c encodeInteger:(NSInteger)_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_CGRECT(d,x)  _ ## x = (__typeof(_ ## x))[d decodeCGRectForKey:@STRINGIFY(x)]
#define FMI_ENCODE_CGRECT(c,x)  [c encodeCGRect:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_CGSIZE(d,x)  _ ## x = (__typeof(_ ## x))[d decodeCGSizeForKey:@STRINGIFY(x)]
#define FMI_ENCODE_CGSIZE(c,x)  [c encodeCGSize:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_CGPOINT(d,x)  _ ## x = (__typeof(_ ## x))[d decodeCGPointForKey:@STRINGIFY(x)]
#define FMI_ENCODE_CGPOINT(c,x)  [c encodeCGPoint:_ ## x forKey:@STRINGIFY(x)]

#define FMI_DECODE_UIEDGEINSETS(d,x)  _ ## x = (__typeof(_ ## x))[d decodeUIEdgeInsetsForKey:@STRINGIFY(x)]
#define FMI_ENCODE_UIEDGEINSETS(c,x)  [c encodeUIEdgeInsets:_ ## x forKey:@STRINGIFY(x)]

FMI_INLINE bool
FMIEqualObjects(id o1, id o2) {
    return (o1 == o2) || (o1 && o2 && [o1 isEqual:o2]);
}
