//
//  Created by Florian Mielke on 28.06.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#define STRINGIFY2( x) #x
#define STRINGIFY(x) STRINGIFY2(x)

#define FMIDECODE_OBJ(d,x)  _ ## x = [d decodeObjectForKey:@STRINGIFY(x)]
#define FMIENCODE_OBJ(c,x)  [c encodeObject:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_OBJ_CLASS(d,x,cl)  _ ## x = (cl *)[d decodeObjectOfClass:[cl class] forKey:@STRINGIFY(x)]
#define FMIDECODE_OBJ_ARRAY(d,x,cl)  _ ## x = (NSArray *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSArray class],[cl class],nil] forKey:@STRINGIFY(x)]
#define FMIDECODE_OBJ_MUTABLE_ORDERED_SET(d,x,cl)  _ ## x = [(NSOrderedSet *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSOrderedSet class],[cl class],nil] forKey:@STRINGIFY(x)] mutableCopy]
#define FMIDECODE_OBJ_MUTABLE_DICTIONARY(d,x,kcl,cl)  _ ## x = [(NSDictionary *)[d decodeObjectOfClasses:[NSSet setWithObjects:[NSDictionary class],[kcl class],[cl class],nil] forKey:@STRINGIFY(x)] mutableCopy]

#define FMIENCODE_COND_OBJ(c,x)  [c encodeConditionalObject:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_IMAGE(d,x)  _ ## x = (UIImage *)[d decodeObjectOfClass:[UIImage class] forKey:@STRINGIFY(x)]
#define FMIENCODE_IMAGE(c,x)  { if (_ ## x) { UIImage * __ ## x = [UIImage imageWithCGImage:[_ ## x CGImage] scale:[_ ## x scale] orientation:[_ ## x imageOrientation]]; [c encodeObject:__ ## x forKey:@STRINGIFY(x)]; } }

#define FMIDECODE_BOOL(d,x)  _ ## x = [d decodeBoolForKey:@STRINGIFY(x)]
#define FMIENCODE_BOOL(c,x)  [c encodeBool:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_DOUBLE(d,x)  _ ## x = [d decodeDoubleForKey:@STRINGIFY(x)]
#define FMIENCODE_DOUBLE(c,x)  [c encodeDouble:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_INTEGER(d,x)  _ ## x = [d decodeIntegerForKey:@STRINGIFY(x)]
#define FMIENCODE_INTEGER(c,x)  [c encodeInteger:_ ## x forKey:@STRINGIFY(x)]

#define FMIENCODE_UINT32(c,x)  [c encodeObject:[NSNumber numberWithUnsignedLongLong:_ ## x] forKey:@STRINGIFY(x)]
#define FMIDECODE_UINT32(d,x)  _ ## x = (uint32_t)[(NSNumber *)[d decodeObjectForKey:@STRINGIFY(x)] unsignedLongValue]

#define FMIDECODE_ENUM(d,x)  _ ## x = (__typeof(_ ## x))[d decodeIntegerForKey:@STRINGIFY(x)]
#define FMIENCODE_ENUM(c,x)  [c encodeInteger:(NSInteger)_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_CGRECT(d,x)  _ ## x = (__typeof(_ ## x))[d decodeCGRectForKey:@STRINGIFY(x)]
#define FMIENCODE_CGRECT(c,x)  [c encodeCGRect:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_CGSIZE(d,x)  _ ## x = (__typeof(_ ## x))[d decodeCGSizeForKey:@STRINGIFY(x)]
#define FMIENCODE_CGSIZE(c,x)  [c encodeCGSize:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_CGPOINT(d,x)  _ ## x = (__typeof(_ ## x))[d decodeCGPointForKey:@STRINGIFY(x)]
#define FMIENCODE_CGPOINT(c,x)  [c encodeCGPoint:_ ## x forKey:@STRINGIFY(x)]

#define FMIDECODE_UIEDGEINSETS(d,x)  _ ## x = (__typeof(_ ## x))[d decodeUIEdgeInsetsForKey:@STRINGIFY(x)]
#define FMIENCODE_UIEDGEINSETS(c,x)  [c encodeUIEdgeInsets:_ ## x forKey:@STRINGIFY(x)]
