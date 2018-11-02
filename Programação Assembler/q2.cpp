#include <bits/stdc++.h>
using namespace std;

int main()
{
    int a, b, c;
    cin >> a >> b >> c;
    bool comp;

    comp = b < a ? 1 : 0;
    if (comp == 0)
        goto p1;
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;

p1:;
    comp = c < a ? 1 : 0;
    if (comp == 0)
        goto p2;
    a = a ^ c;
    c = a ^ c;
    a = a ^ c;

p2:;
    comp = c < b ? 1 : 0;
    if (comp == 0)
        goto p3;
    b = b ^ c;
    c = b ^ c;
    b = b ^ c;

p3:;

    printf("a: %d, b: %d, c: %d\n", a, b, c);
}