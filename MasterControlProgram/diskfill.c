// // main.c // Posix // // Created by The Wizard of OZ on 06/11/2017. // Copyright © 2017 The Wizard of OZ. All rights reserved. //

#include <stdio.h>
#include <stdlib.h>
#include <sys/statvfs.h>
#include "strings.h"
#include <locale.h>

float        get_free_space_info( char *);




char *
format_integer( long long int n, char *out ) {
    
        int c;
        char buf[100];
        char *p;
        char* q = out; // Backup pointer for return...
        snprintf(buf, 100, "%llu", n);
        c = 2 - strlen(buf) % 3;
        
        for (p = buf; *p != 0; p++) {
            *out++ = *p;
            if (c == 1) {
                *out++ = ',';
            }
            c = (c + 1) % 3;
        }
        *--out = 0;
        return q;
}


float
get_free_space_info(char *fs) {
    struct statvfs vfs;
    statvfs(fs, &vfs);
    char buffer[100];
    
    unsigned long long block_size, avaialable_blocks, free_blocks;
    block_size = vfs.f_bsize;
    avaialable_blocks = vfs.f_bavail;
    free_blocks = vfs.f_blocks;
    
    printf("Dimensioni del disco in bytes : %*s bytes\n", 20, format_integer(free_blocks * block_size, buffer ));
    printf("Spazio libero in bytes        : %*s bytes\n", 20, format_integer(avaialable_blocks * block_size, buffer ));
    
    
    return (float) avaialable_blocks / free_blocks;
}

// 256 702 028 972 032

int main( int argn, char *argv[]) {
    if ( argn <= 1 ) 
    {
         printf("Manca il path\n");
         exit(1);
    }
    printf ("Analisi dello spazio fatto per il path :%s\n", argv[1]);
    char *path = argv[1];
    float pc;
    pc = get_free_space_info( path );
    printf("Percento di spazio libero su %s = %f%%\n", path, pc * 100 );
    return 0;
}
