/* 
 * Compile with 
 * 
 *  gcc -o ble blec341.c 
 * 
 *  usage:
 * 
 * ./ble
 * 
 * once started type quit to terminate the program, 
 * be sure /dev/ttyAMA0 has the correct permission and 
 * ttyAMA0 is not used into inittab
 */
#include <termios.h>
#include <stdint.h>
#include <unistd.h> 
#include <stdio.h>
#include <stdlib.h> 
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <sys/stat.h>
#include <string.h>
#include <errno.h>
/* 
 * these defaults are reported into ble-cc41-a datasheet
 */
#define PORT "/dev/ttyAMA0"
#define SPEED B9600
#define DATA_BUFFER_SIZE 512

int fd;

int openAndConfigureInterface(void){
    struct termios tty;
    fd= open(PORT, O_RDWR);
    if ( fd< 0 ) { 
        printf("Error %d opening %s : %s\n", errno, PORT, strerror( errno ));
        return ( -1 );
    }
    memset( &tty, 0, sizeof(tty));
    if ( tcgetattr(fd,&tty) != 0 ) { 
        printf("ERROR! %s\n", strerror(errno));
        return (-1);
    }
    cfsetospeed(&tty, SPEED);
    cfsetispeed(&tty, SPEED);
        
    tty.c_iflag &= ~IGNBRK;
    tty.c_lflag = 0;
    tty.c_oflag = 0;
        tty.c_cc[VMIN] = 0;
    tty.c_cc[VTIME] = 5;
    tty.c_iflag &= ~(IXON, IXOFF, IXANY );
    tty.c_cflag |= ( CLOCAL | CREAD );
    tty.c_cflag &= ~CSTOPB;
    tty.c_cflag &= ~CRTSCTS;

    if ( tcsetattr( fd, TCSANOW, &tty ) != 0 ) { 
        printf("ERROR %s\n", strerror(errno));
        return(-2);
    }
    return(0);
}

int main( int argc, char *argv[] ) { 
    char buffer[DATA_BUFFER_SIZE];
    int n = 0;
    char p[512];

    printf("Console for BLE-CC41-A device.\n");
    printf("Alessio Palma December 2015\n");

    printf("(!) - type quit to exit the program\n");
    
    openAndConfigureInterface();

    while( 1 ) { 
        printf("\nBLE <- ");
                scanf("%s",&p);

        if ( strncmp(p, "quit",4) == 0 ) { 
            printf("No input, exiting from program\n");
            break;
        }
        /*
         * wait a bit to allow the device to produce a response
         */
        sleep(1); 
        /*
         * minicom adds linefeed BEFORE the carrige return 
         * and ble-cc41-a does not like it.
         */
        strncat(p, "\r\n",2);
        write(fd,p,strlen(p));

        printf("BLE -> ");
        do { 
            memset( buffer,0,sizeof(buffer));
            n = read(fd,buffer,sizeof(buffer)) > 0;
            if ( n < 0 ) { 
                printf("ERROR : %s\n", strerror(errno));
            }
            printf("%s",buffer);
        } while(  n > 0 );
    }
    printf("closing serial port\n");
    close(fd);

    return(0);
}
