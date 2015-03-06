#include <stdio.h>

#define SIZE 11
int array[SIZE] = { 6, 9, 3, 1, 7, 12, 2, 18, 4, 15, 0 };

void print()
{
    int i;
    for (i = 0; i < SIZE; i++)
    {
        printf ("%d\n", array[i]);
    }
}

void swap(int* elem1, int* elem2)
{
    int tmp = *elem1;
    *elem1 = *elem2;
    *elem2 = tmp;
}

int* partition(int* pp, int* rp)
{
    int x = *rp;
    int* ip = pp-1;
    int* jp = pp;

    while (jp < rp)
    {
        if (*jp <= x)
        {
            ip++;
            swap(ip, jp);
        }
        jp++;
    }
    swap(ip + 1, rp);

    return ip + 1;
}

void quicksort(int* first, int* last)
{
    int* mid;
    
    if (first < last)
    {
	mid = partition(first, last);
	quicksort(first, mid - 1);
	quicksort(mid + 1, last);
    }
}

int main()
{
    quicksort(array, array + SIZE - 1);
    print();
}