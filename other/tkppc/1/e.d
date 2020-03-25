import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Path = Tuple!(int, "to", long, "c");

void main()
{
    auto N = readln.chomp.to!int;
    Path[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0]-1;
        auto b = abc[1]-1;
        long c = abc[2];
        T[a] ~= Path(b, c);
        T[b] ~= Path(a, c);
    }

    int s, t;
    long m;
    auto LS = new long[][](2, N);
    void s1(int i, int p, long c) {
        if (m < c || (m == c && i < s)) { m = c; s = i; }
        foreach (n; T[i]) if (n.to != p) s1(n.to, i, c + n.c);
    }
    s1(0, -1, 0);
    m = 0;
    void s2(int i, int p, long c) {
        if (m < c || (m == c && i < t)) { m = c; t = i; }
        LS[0][i] = c;
        foreach (n; T[i]) if (n.to != p) s2(n.to, i, c + n.c);
    }
    s2(s, -1, 0);
    void s3(int i, int p, long c) {
        LS[1][i] = c;
        foreach (n; T[i]) if (n.to != p) s3(n.to, i, c + n.c);
    }
    s3(t, -1, 0);
    m = min(s, t);

    foreach (i; 0..N) {
        auto a = LS[0][i];
        auto b = LS[1][i];
        writeln((a == b ? m : a > b ? s : t) + 1);
    }
}