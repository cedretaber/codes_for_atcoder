import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto D = readln.chomp.to!int;
    auto K = readln.chomp.to!int;

    auto MAP = new int[][](1000, 1000);
    int[] xs, ys;
    foreach (i; 1..N+1) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0];
        auto y = xy[1];
        MAP[y][x] = i;
        xs ~= x;
        ys ~= y;
    }

    auto G = new int[][N];
    foreach (i; 0..N) {
        foreach (y; max(0, ys[i]-D)..min(1000, ys[i]+D+1)) {
            foreach (x; max(0, xs[i]-D)..min(1000, xs[i]+D+1)) {
                if (MAP[y][x] != 0 && MAP[y][x]-1 != i && (xs[i] - x)^^2 + (ys[i] - y)^^2 <= D^^2) {
                    G[i] ~= MAP[y][x]-1;
                }
            }
        }
    }

    auto es = new int[](N);
    es[] = -1;
    es[0] = M;
    auto ss = [0];
    foreach (d; 1..K+1) {
        if (ss.empty) break;
        int[] nss;
        foreach (s; ss) {
            foreach (t; G[s]) if (es[t] == -1) {
                es[t] = d + M;
                nss ~= t;
            }
        }
        ss = nss;
    }
    writeln(es.count!(e => e > K));
}