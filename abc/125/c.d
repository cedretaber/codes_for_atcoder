import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5+1] L, R;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    auto g = AS[0];
    foreach (i, a; AS) {
        g = gcd(g, a);
        L[i] = g;
    }
    g = AS[$-1];
    foreach_reverse (i, a; AS) {
        g = gcd(g, a);
        R[i] = g;
    }

    int max_g;
    foreach (i; 0..N) {
        if (i == 0) {
            g = R[i+1];
        } else if (i == N-1) {
            g = L[i-1];
        } else {
            g = gcd(L[i-1], R[i+1]);
        }
        max_g = max(max_g, g);
    }
    writeln(max_g);
}