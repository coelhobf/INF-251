#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n;
    cin >> n;

    bool comp;

    int *v = new int[n];
    for (int i = 0; i < n; i++)
    {
        v[i] = i + 1;
    }

    int i;
    int *p;
    int val;

    n = n - 1;
    int sum = 0;
loop:
    comp = n < 0 ? 1 : 0;
    if (comp != 0) goto finish;

    i = n; // << 2
    p = v + i;
    val = *p;

    sum = sum + val;
    n = n - 1;

    goto loop;

finish:

    printf("sum of v: %d\n", sum);
    delete[] v;
}