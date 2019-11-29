import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Path = Tuple!(int, "i", int, "to", int, "c");

void main()
{
    auto N = readln.chomp.to!int;
    Path[][] G;
    G.length = N;
    foreach (i; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        G[a] ~= Path(i, b, 0);
        G[b] ~= Path(i, a, 0);
    }
    int max_n;
    foreach (n; G) max_n = max(max_n, n.length.to!int);
    int[] SC;
    SC.length = N;
    SC[0] = 1;
    void solve(int i, int par) {
        int c = (SC[i] + 1) % (max_n + 1);
        if (c == 0) c = 1;
        foreach (ref p; G[i]) if (p.to != par) {
            p.c = c;
            SC[p.to] = c;
            solve(p.to, i);
            c = (c+1) % (max_n + 1);
            if (c == 0) c = 1;
        }
    }
    solve(0, -1);
    Path[] R;
    foreach (n; G) foreach (p; n) if (p.c) R ~= p;
    sort!"a.i < b.i"(R);
    writeln(max_n);
    foreach (r; R) writeln(r.c);
}