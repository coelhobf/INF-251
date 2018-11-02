#include <bits/stdc++.h>
using namespace std;

int main()
{
    srand(time(0));
    int n;
    cin >> n;

    bool comp;
    int aux;
    int val;
    int i;
    int *p;

    int *v = new int[n];
    for (int i = 0; i < n; i++)
    {
        v[i] = rand() % 10;
    }


    aux = *v;
    n = n - 1;
loop:
    comp = 0 < n ? 1 : 0;
    if (comp == 0)
        goto finish;

    i = n; // << 2;
    p = v + i;
    val = *p;

    comp = aux < val ? 1 : 0;
    if (comp == 0)
        goto out;

    aux = val + 0;

out:

    n = n - 1;
    goto loop;

finish:

    printf("max of v: %d\n", aux);
    delete[] v;
}