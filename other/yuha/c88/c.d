import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto N = readln.chomp.to!int;
    string[] ns, ms;
    foreach (_; 0..N) {
        auto n = readln.chomp;
        ns ~= n;
        ms ~= n;
    }
    sort(ns);
    int[string] dic;
    foreach (i, n; ns) dic[n] = i.to!int;

    auto rs = new int[][](N, N);
    foreach (i; 0..N) {
        auto ll = readln.split;
        auto v = ll[0];
        auto u = ll[3];
        auto x = u == "good" ? 1 : -1;
        if (rs[dic[ms[i]]][dic[v]] == 0 || rs[dic[ms[i]]][dic[v]] == x) {
            rs[dic[ms[i]]][dic[v]] = x;
            rs[dic[v]][dic[ms[i]]] = x;
        } else {
            writeln("No answers");
            return;
        }
    }

    int max_n;
    int[] max_s;
    foreach (uint s; 0..(1<<N)) {
        auto n = popcnt(s);
        if (n < max_n) continue;
        int[] ss;
        foreach (i; 0..N) {
            foreach (j; 0..N) {
                if (rs[i][j] == 0) continue;
                auto same = (!!(s & (1<<i))) == (!!(s & (1<<j)));
                if (same && rs[i][j] ==-1 || !same && rs[i][j] == 1) goto ng;
            }
        }
        foreach (i; 0..N) if (s & (1<<i)) ss ~= i;
        if (n > max_n || ss < max_s) max_s = ss;
        max_n = n;
        ng:
    }
    if (max_s.empty) {
        writeln("No answers");
    } else {
        foreach (i; max_s) writeln(ns[i]);
    }
}