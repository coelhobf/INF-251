#include <bits/stdc++.h>
using namespace std;

int main()
{
    int a, b;
    cin >> a >> b;
    int t = a;
    bool comp;

    int c = 0;
loop:
    comp = 0 < a ? 1 : 0;
    if (comp == 0)
        goto finish;
    c = c + b;
    a = a - 1;
    goto loop;

finish:

    printf("c: %d = a: %d * b: %d\n", c, t, b);
}