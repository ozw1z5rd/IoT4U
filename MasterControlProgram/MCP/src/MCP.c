#include <kore/kore.h>
#include <kore/http.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/statvfs.h>
#include "strings.h"
#include <locale.h>

int		page(struct http_request *);
char *		format_integer( long long int, char *);
void            get_free_space_info( char *, char *);

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

void
get_free_space_info(char *buff, char *fs) {
    struct statvfs vfs;
    statvfs(fs, &vfs);
    char buffer[100];
 
    unsigned long long block_size, avaialable_blocks, free_blocks;
    block_size = vfs.f_bsize;
    avaialable_blocks = vfs.f_bavail;
    free_blocks = vfs.f_blocks;
    sprintf(buff , "Dimensioni del disco in bytes : %*s bytes\n", 20, format_integer(free_blocks * block_size, buffer ));
    kore_log( LOG_INFO, buff );    
    sprintf(&buff[strlen(buff)], "Spazio libero in bytes        : %*s bytes\n", 20, format_integer(avaialable_blocks * block_size, buffer ));
    kore_log( LOG_INFO, buff );

}

int
page(struct http_request *req)
{
        char s_response[256];
	get_free_space_info( s_response, "/bin" );
	http_response(req, 200, s_response, strlen(s_response));
	return (KORE_RESULT_OK);
}


