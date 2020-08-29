import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    int w = 1;
    int[] as, bs;
    auto ps = new int[](H);
    foreach (h; 0..H) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0];
        auto B = ab[1];
        as ~= A;
        bs ~= B;
        if (w != -1 && A <= w && w <= B) {
            w = B+1;
            if (w > W) {
                w = -1;
            }
        }
        ps[h] = w;
    }
    w = W;
    auto qs = new int[](H);
    foreach_reverse (i, w; ps) {
        if (ps[w] == -1) continue;

        auto A = as[i];
        auto B = bs[i];
        if ()
    }
}

/*

.***
*...
.**.
.***

..**
***.
..**

..**..
***...
.****.

..**..
..****
**....


**....
....**
*****.


**.....
.....**
..**...
...**..
....**.
.....**

**.....
.**....
..**...
...**..
....**.

.**...
*.....
..***.
...***
..***.

...***
**....

*/