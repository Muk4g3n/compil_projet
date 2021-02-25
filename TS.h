#include <stdlib.h>
#include <stdio.h>

typedef struct
{
    int state;
    char name[20];
    char code[20];
    char type[20];
    float val;
} element;

typedef struct
{
    int state;
    char name[20];
    char type[20];
} elt;

element tab[2000];
elt tabs[40], tabm[40];
extern char sav[20];

//initialisation
void initiliasiation()
{
    int i;
    for (i = 0; i < 1000; i++)
        tab[i].state = 0;

    for (i = 0; i40; i++)
    {
        tabs[i].state = 0;
        tabm[i].state = 0;
    }
}