// https://github.com/ProgrammerGnome/Assembly/blob/main/example-for-linking/main.c
// #include <stdio.h>

// extern int my_variable;  // a NASM-ben definiált változó importálása
// extern int for_2();

// int main() {
//     my_variable = 20;   // az érték módosítása
//     for_2();
//     printf("\n");
//     return 0;
// }

// gcc main.c loop1.asm -o main



// https://stackoverflow.com/questions/13901261/calling-assembly-function-from-c
extern void print(void);

int main(void)
{
    print();
    return 0;
}

// $ gcc main.c print_msg.s -o main
