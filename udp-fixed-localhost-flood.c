#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

  int n = 10 *1000*1000;
  printf("%i\n",n);

  char buff[64];
  memset(&buff, 'Q', sizeof(buff));
  const char * hostname = "127.0.0.1";
  const char * portname = "9999";
  struct addrinfo hints;
  memset(&hints, 0, sizeof(hints));
  hints.ai_family=AF_UNSPEC;
  hints.ai_socktype=SOCK_DGRAM;
  hints.ai_protocol=0;
  hints.ai_flags=AI_ADDRCONFIG;
  struct addrinfo* res=0;
  int err=getaddrinfo(hostname,portname,&hints,&res);
  if (err!=0) {
     return EXIT_FAILURE;
  }

  int fd=socket(res->ai_family,res->ai_socktype,res->ai_protocol);
  if (fd==-1) {
    return EXIT_FAILURE;
  }

  do {
    if (sendto(fd,buff,sizeof(buff),0,
      res->ai_addr,res->ai_addrlen)==-1) {
      return EXIT_FAILURE;
    }
  } while(n--);

  return EXIT_SUCCESS;
}
