import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto x = nx[1];
    if (x == 1 || x == N*2-1) {
        writeln("No");
        return;
    }
    writeln("Yes");

    if (N == 2) {
        writeln("1\n2\n3");
        return;
    }

    auto res = new int[](N*2-1);
    auto fs = new bool[](N*2);
    res[N-1] = x;
    fs[x] = true;
    res[N-2] = x-1;
    fs[x-1] = true;
    res[N] = x+1;
    fs[x+1] = true;
    if (x == 2) {
        res[N-3] = x+2;
        fs[x+2] = true;
    } else {
        res[N+1] = x-2;
        fs[x-2] = true;
    }
    int n = 1;
    foreach (ref r; res) if (r == 0) {
        while (fs[n]) ++n;
        r = n++;
    }
    foreach (ref r; res) writeln(r);
}