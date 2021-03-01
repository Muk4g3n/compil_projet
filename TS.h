#include <stdlib.h>
#include <stdio.h>
#include <string.h>
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

element tab[1000];
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

void inserer(char entite[], char code[], char type[], float val, int i, int y)
{
    switch (y)
    {
    case 0:
        /* code */
        tab[i].state = 1;
        strcpy(tab[i].name, entite);
        strcpy(tab[i].code, code);
        strcpy(tab[i].type, type);
        tab[i].val = val;
        break;

    case 1:
        tabm[i].state = 1;
        strcpy(tabm[i].name, entite);
        strcpy(tabm[i].type, type);
        break;

    case 2:
        tabs[i].state = 1;
        strcpy(tabs[i].name, entite);
        strcpy(tabs[i].type, type);
        break;
    }
}

void rechercher(char entite[], char type[], float val, int y)
{
    int i, j;
    switch (y)
    {
    case 0:
        for (i = 0;
             (
                 (i < 1000) &&
                 (tab[i].state == 1) &&
                 (strcmp(entite, tab[i].name) != 0));
             i++)
            ;
        if (i < 1000)
        {
            inserer(entite, type, val, i, 0);
        }
        else
        {
            printf("entite existe deja\n");
        }
        break;

    case 1:
        for (i = 0;
             (
                 (i < 40) &&
                 (tabm[i].state == 1) &&
                 (strcmp(entite, tabm[i].name) != 0));
             i++)
            ;
        if (i < 40)
        {
            inserer(entite, type, val, i, 1);
        }
        else
        {
            printf("entite existe deja\n");
        }
        break;
    case 2:
        for (i = 0;
             (
                 (i < 40) &&
                 (tabs[i].state == 1) &&
                 (strcmp(entite, tabs[i].name) != 0));
             i++)
            ;
        if (i < 40)
        {
            inserer(entite, type, val, i, 2);
        }
        else
        {
            printf("entite existe deja\n");
        }
        break;
    }
}

void afficher()
{
    int i, j;
    printf("la table des symboles\n");
    printf("la table de constant et des idf\n");
    for (i = 0; i < 1000; i++)
        if (tab[i].state == 1)
        {
            printf("\t |%10s|%15s|%12s|%12f\n", tab[i].name, tab[i].code, tab[i].type, tab[i].val);
        }

    printf("la table des mot cles\n");
    for (i = 0; i < 40; i++)
        if (tabm[i].state == 1)
        {
            printf("\t |%10s|%12s\n", tabm[i].name, tabm[i].type);
        }

    printf("la table des separateurs\n");
    for (i = 0; i < 40; i++)
        if (tabs[i].state == 1)
        {
            printf("\t |%10s|%12s\n", tabs[i].name, tabs[i].type);
        }
}