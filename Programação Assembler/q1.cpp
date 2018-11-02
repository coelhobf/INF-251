#include <bits/stdc++.h>
using namespace std;

int main()
{
    int a, b;
    cin >> a >> b;

    bool comp = a < b ? 1 : 0;

    if (comp == 0) goto out;
        printf("b: %d é maior\n", b);
        goto fim;
    out:;
        printf("a: %d é maior\n", a);
    fim:;
}