import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ps = new bool[](10^^5+1);
    ps[] = true;
    ps[0] = ps[1] = false;
    foreach (i; 3..10^^5+1) if (ps[i]) {
        if (i%2 == 0) {
            ps[i] = false;
            continue;
        }
        int j = i*2;
        while (j <= 10^^5) {
            ps[j] = false;
            j += i;
        }
    }
    auto PS = new int[](10^^5+1);
    foreach (n; 3..10^^5+1) {
        PS[n] += PS[n-1];
        if (n%2 == 0) continue;
        if (ps[n] && ps[(n+1)/2]) PS[n] += 1;
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto lr = readln.split.to!(int[]);
        writeln(PS[lr[1]] - PS[lr[0]-1]);
    }
}