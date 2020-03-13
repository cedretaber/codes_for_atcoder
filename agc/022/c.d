import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int , "to", int, "d");

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    auto bs = readln.split.to!(int[]);

    P[][] G;
    G.length = 51;
    foreach (i; 1..51) {
        foreach (j; 1..i+1) {
            G[i] ~= P(i%j, j);
        }
    }

    bool check(int i, int j, ulong m) {
        if (i == j) return true;
        
        auto FS = new bool[](51);
        FS[i] = true;
        auto ss = [i];
        while (!ss.empty) {
            auto h = ss[0];
            ss = ss[1..$];
            foreach (n; G[h]) if (!FS[n.to] && (m & (1UL<<n.d))) {
                if (n.to == j) return true;
                FS[n.to] = true;
                ss ~= n.to;
            }
        }
        return false;
    }

    ulong m = (1UL<<51)-1 ^ 1;
    foreach (i; 0..N) {
        if (!check(as[i], bs[i], m)) {
            writeln(-1);
            return;
        }
    }
    foreach_reverse (x; 1..51) {
        m ^= 1UL<<x;
        foreach (i; 0..N) if (!check(as[i], bs[i], m)) goto ng;
        continue;
        ng:
        m |= 1UL<<x;
    }
    writeln(m);
}