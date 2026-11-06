#include <unistd.h>
#include <stdio.h>
int main(void)
{
 char *env[] = { "PATH=/usr/bin:/bin", "IFS= \t\n", NULL };
 execle("/usr/bin/tail", "tail", "-n", "10",
 "/var/log/helios/app.log", (char *)NULL, env);
 perror("execle");
return 1;
}
