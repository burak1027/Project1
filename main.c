#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "a.h"
#include "MergeSort.h"
char* commandNames[]={"cd","./project.sh","./script2.sh",};
//name of commands that can be used

//it executes the change directory command in the c
int cd(char **args){
  if (args[1] == NULL) {
    printf("argument expected\n");
    //if argument is null print a message
    return 0;
  }
   else {
    chdir(args[1]);
    }
  
  return 1;
}
//it executes shell file named project.sh
int punctuationCorrector(char **args){
	char *cmdargs[] = {
 "/bin/bash",
 "./project.sh",
 "NULL",
 NULL};
 if (args[1] == NULL) {
    printf("argument expected\n");
     //if argument is null print a message
    return 0;
  }
  else{
	  //if there is an argument pyt it in the argument index of cmdargs and executes the programm
	  cmdargs[2]=malloc(sizeof(args[1]));
	  strcpy(cmdargs[2],args[1]);
	  execvp(cmdargs[0],cmdargs);
	  
    }
return 1;
}
//it executes shell file named scritp2.sh
int script2(char **args){
	char *cmdargs[] = {
 "/bin/bash",
 "./script2.sh",
 "NULL",
 NULL};
 if (args[1] == NULL) {
    printf("expected argument");
     //if argument is null print a message
    return 0;
  }
  else{
	  //if there is an argument pyt it in the argument index of cmdargs and executes the programm
	  cmdargs[2]=malloc(sizeof(args[1]));
	  strcpy(cmdargs[2],args[1]);
	  execvp(cmdargs[0],cmdargs);
	  
    }
return 1;
}
//function pointer array of the functions that we execute
int (*COMMANDS[])(char ** args)={
&cd , &punctuationCorrector, &script2
};
 char *read_input(void){
  int length = 2048;
  //the size of the array is 2048 bit
  int index = 0;
  char *input = malloc(sizeof(char) * length);
  // memory allocated in the size of 2048 character
  int c;
  // input that will be returned
  
  
  while (1) {
    // Read a character
    c = getchar();

    // If we hit end of file or if we enter next line character return input
    if (c == EOF || c == '\n') {
      input[index] = '\0';
      return input;
      //return input
    } 
    else {
      input[index] = c;
      //put characters to input array
    }
    index++;

    if (index >= length) {
      printf("input is longer than expected");
    }
  }
}

char **split_line(char *line)
{
  int size = 2048;
  int index = 0;
  char **tokens = malloc(size * sizeof(char*));
   //memory allocated in the size of 2048 character
  char *token;
  token = strtok(line," ");
  while (token != NULL) {
    tokens[index] = token;
    index++;
    token = strtok(NULL," ");
  }
  tokens[index] = NULL;
  return tokens;
}
//this function call the function that executes the input
int execute(char **args){
for(int i = 0 ; i < 3; i++){

    if(strcmp(args[0],commandNames[i])==0){
		//if the command is in the comman names array, call the function of it
	 return COMMANDS[i](args);

    }
   
    } 
printf("there is no function called %s pleases try another\n",args[0]);

return 0;    
}
int main(int argc, char *argv[]) {
printf("Be sure that all the files in the same directory\n");
printf("In this program you are allowed to used cd command\n");
printf("and you can execute two shell file called project.sh and script.sh\n");
printf("Input:\n");
char *input;
char **arguments;
int status;
input = read_input();
//input is read with read_input function
arguments=split_line(input);
//and split_line function split the input by " "
status = execute(arguments);
//program executed, status becomes zero if it fail, if it executes succesfuly
//it become 1
if(status == 0){
printf("A problem is occured when programm is executing");
}
return 0;
}
