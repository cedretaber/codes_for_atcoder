import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] as, bs;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        as ~= a;
        bs ~= b;
    }

    auto S = readln.chomp;
    int c;
    while (S[0] == '"') {
        ++c;
        S = S[1..$];
    }
    S = S[5..$];
    char[] ss;
    while ('0' <= S[0] && S[0] <= '9') {
        ss ~= S[0];
        S = S[1..$];
    }
    auto s = ss.to!int-1;
    bool[] qs;
    if (S[0] == 'w') {
        qs ~= true;
        S = S[1..$];
    } else {
        qs ~= false;
    }
    foreach (_; 0..c) {
        S = S[1..$];
        if (S.empty || S[0] == '"') {
            qs ~= false;
        } else {
            S = S[2..$];
            qs ~= true;
        }
    }

    auto cs = new bool[](N);
    cs[s] = true;
    foreach (q; qs) {
        auto ds = new bool[](N);
        if (q) {
            foreach (i; 0..M) if (cs[bs[i]]) {
                ds[as[i]] = true;
            }
        } else {
            auto ts = new int[](N);
            foreach (i; 0..M) if (cs[bs[i]]) {
                ts[as[i]] += 1;
            }
            c = cs.count(true).to!int;
            ds[] = true;
            foreach (i, t; ts) if (t == c) ds[i] = false;
        }
        cs = ds;
    }
    writeln(cs.count(true));
}