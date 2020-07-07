import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias Path = Tuple!(int, "to", bool, "used");

void main()
{
    auto nge = readln.split.to!(int[]);
    auto N = nge[0];
    auto E = nge[2];
    auto G = new Path[][N+1];
    foreach (p; readln.split.to!(int[])) {
        G[p] ~= Path(N, false);
    }
    foreach (_; 0..E) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0];
        auto b = ab[1];
        G[a] ~= Path(b, false);
        G[b] ~= Path(a, false);
    }

    auto memo = new bool[](N+1);
    bool solve(int i) {
        if (i == N) return true;
        foreach (ref n; G[i]) if (!n.used && !memo[n.to]) {
            memo[n.to] = true;
            if (solve(n.to)) {
                n.used = true;
                return true;
            }
        }
        return false;
    }
    int r;
    for (;;) {
        memo[] = false;
        memo[0] = true;
        if (solve(0)) {
            ++r;
        } else {
            break;
        }
    }
    writeln(r);
}