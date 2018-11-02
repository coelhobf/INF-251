#include <bits/stdc++.h>
using namespace std;

int main()
{
    int a, b;
    bool comp;
    cin >> a >> b;
    int t = b;

    int c = 0;
loop:
    comp = b < a ? 1 : 0;
    if (comp != 0)
        goto finish;

    c = c + 1;
    b = b - a;
    goto loop;

finish:

    printf("b: %d / a: %d = c: %d\n", t, a, c);
}