import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] XS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i, x; readln.split.to!(long[])) XS[i] = x;
    sort(XS[0..N]);

    N -= 1;
    long r;
    foreach (i; 0..N) {
        r += (XS[i+1] - XS[i]) * (N - i) * (i + 1);
    }
    writeln(r);
}

/*

4

3
 3-1 + 3-1
  3-2 + 3-2 + 3-2

*/