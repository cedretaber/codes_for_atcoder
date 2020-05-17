import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] G;
    G.length = N;
    foreach (i; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        G[B] ~= A;
    }

    auto res = new int[](N);
    auto ss = [0];
    while (!ss.empty) {
        int[] nss;
        foreach (s; ss) {
            foreach (n; G[s]) if (res[n] == 0) {
                res[n] = s+1;
                nss ~= n;
            }
        }
        ss = nss;
    }
    writeln("Yes");
    foreach (r; res[1..$]) writeln(r);
}