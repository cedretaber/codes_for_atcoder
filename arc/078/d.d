import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5+1] GP;
bool[10^^5+1] CS;
int[10^^5+1] PS;

int find_path(int N)
{
    auto ss = [[0, 0]];
    for (;;) {
        auto h = ss[0];
        auto i = h[0];
        auto s = h[1];
        ss = ss[1..$];
        
        PS[i] = s;

        if (s == N-1) return i+1;

        foreach (n; GP[s]) {
            if (CS[n]) continue;
            CS[n] = true;
            ss = [[i+1, n]] ~ ss;
        }
    }
}

int count_path(int s)
{
    if (CS[s]) return 0;
    CS[s] = true;
    auto r = 1;
    foreach (n; GP[s]) r += count_path(n);
    return r;
}

void main()
{
    auto N = readln.chomp.to!int;

    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0] - 1;
        auto b = ab[1] - 1;
        GP[a] ~= b;
        GP[b] ~= a;
    }

    auto m = find_path(N);
    auto path = PS[0..m];
    CS[] = false;
    foreach (p; path) CS[p] = true;
    int f, s;
    foreach (p; path[0..($+1)/2]) {
        f += 1;
        foreach (n; GP[p]) f += count_path(n);
    }
    foreach (p; path[($+1)/2..$]) {
        s += 1;
        foreach (n; GP[p]) s += count_path(n);
    }

    writeln(f > s ? "Fennec" : "Snuke");
}