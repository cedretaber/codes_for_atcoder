import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = new int[](101);
    foreach (n; 2..N+1) {
        foreach (d; 2..N+1) {
            while (n%d == 0) {
                cs[d] += 1;
                n /= d;
            }
        }
    }
    int a, b, c, d, e;
    foreach (x; cs) {
        if (x >= 74) ++a;
        if (x >= 24) ++b;
        if (x >= 14) ++c;
        if (x >= 4) ++d;
        if (x >= 2) ++e;
    }
    writeln(a + b*(e-1) + c*(d-1) + d*(d-1)/2*(e-2));
}