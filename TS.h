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
    int taille;
    char *charVal;
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
void initialisation()
{
    int i;
    for (i = 0; i < 1000; i++)
    {
        tab[i].state = 0;
        tab[i].taille = 0;
    }

    for (i = 0; i < 40; i++)
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

void rechercher(char entite[], char code[], char type[], float val, int y)
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
            inserer(entite, code, type, val, i, 0);
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
            inserer(entite, code, type, val, i, 1);
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
            inserer(entite, code, type, val, i, 2);
        }
        else
        {
            printf("entite existe deja\n");
        }
        break;
    }
}
//retourne 1 si la bib existe 0 sinon
int rechercher_BIB(char *bib)
{
    int i = 0;
    while (i < 40)
    {
        if (strcmp(bib, tabm[i].name) == 0)
        {
            return 1;
        }
        i++;
    }
    return 0;
}

void afficher()
{
    int i;

    printf("\n/***************Table des symboles IDF***************/");

    printf("\n/***************Table des symboles IDF******************/\n");
    printf("____________________________________________________________________\n");
    printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
    printf("____________________________________________________________________\n");

    for (i = 0; i < 1000; i++)
    {

        if (tab[i].state == 1)
        {
            printf("\t|%10s |%15s | %12s | %12f\n", tab[i].name, tab[i].code, tab[i].type, tab[i].val);
        }
    }

    printf("\n\n\n/***************Table des Mot cles***************/");
    printf("\n/***************Table des Mot cles******************/\n");
    printf("____________________________________________________________________\n");
    printf("\t| Nom_Entite |  Code_Entite\n");
    printf("____________________________________________________________________\n");
    for (i = 0; i < 40; i++)
    {

        if (tabm[i].state == 1)
        {

            printf("\t|%10s |%15s\n", tabm[i].name, tabm[i].type);
        }
    }

    printf("\n\n\n/***************Table des Separateurs***************/");
    printf("\n/***************Table des Separateurs******************/\n");
    printf("____________________________________________________________________\n");
    printf("\t| Nom_Entite |  Code_Entite\n");
    printf("____________________________________________________________________\n");
    for (i = 0; i < 40; i++)
    {

        if (tabs[i].state == 1)
        {

            printf("\t|%10s |%15s\n", tabs[i].name, tabs[i].type);
        }
    }
}
// reourne la position de l'entite
int get_position(char entite[])
{
    int i = 0;
    while (i < 1000)
    {

        if (strcmp(entite, tab[i].name) == 0)
            return i;
        i++;
    }

    return -1;
}

//retourne 1 si idf est doublement declaré, 0 sinon
int double_declaration(char entite[])
{
    int pos = get_position(entite);

    if (pos != -1)
    {
        if (strcmp(tab[pos].type, "nothing") == 0)
        {
            return 0;
        }
        else
            return 1;
    }
    else
        return -1;
}

// inserer le type d'une variable dans la table de symboles
void inserer_type(char entite[], char type[])
{
    int pos = get_position(entite);

    if (strcmp(tab[pos].type, "nothing") == 0)
    {
        strcpy(tab[pos].type, type);
    }
}

void inserer_taille(char entite[], int taille)
{
    int pos = get_position(entite);
    if (strcmp(entite, tab[pos].name) == 0)
    {
        tab[pos].taille = taille;
    }
}
