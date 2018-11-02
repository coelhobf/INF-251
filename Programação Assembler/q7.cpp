#include <bits/stdc++.h>
using namespace std;

int main()
{
    srand(time(0));
    int n, el;
    cin >> n >> el;

    bool cond;
    int aux;
    int val;
    int i;
    int *p;

    int *v = new int[n];
    for (int i = 0; i < n; i++)
    {
        v[i] = rand() % 10;
    }

    aux = -1;
    n = n - 1;

loop:;
    cond = n < 0 ? 1 : 0;
    if (cond != 0)
        goto finish;

    i = n; // << 2;
    p = v + 1;
    val = *p;

    if (val != el)
        goto out;

    aux = n + 0;

out:;

    n = n - 1;
    goto loop;

finish:;

    printf("index of el: %d\n", aux);
    delete[] v;
}