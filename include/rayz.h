#include <stdlib.h>

extern void* zig_malloc(size_t size);
extern void* zig_calloc(size_t nitems, size_t size);
extern void* zig_realloc(void* ptr, size_t size);
extern void zig_free(void* ptr);
