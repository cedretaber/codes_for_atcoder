import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.split.to!(int[]);
    sort!"a > b"(S);
    int[] NS;
    {
        int last, c;
        foreach (s; S) {
            if (s == last) {
                ++c;
            } else {
                if (c) NS ~= c;
                c = 1;
                last = s;
            }
        }
        NS ~= c;
    }

    int[19] ts;
    ts[N] = 1;
    int tt = 1;
    foreach (ns; NS) {
        auto c = ns;

        if (tt < c) {
            writeln("No");
            return;
        }

        int[19] ss;
        foreach_reverse (i, ref t; ts) if (t) {
            if (c == 0) break;
            auto d = min(c, t);
            c -= d;
            t -= d;
            tt = tt - d + i.to!int*d;
            foreach (ref s; ss[0..i]) s += d;
        }
        ts[] += ss[];
    }
    writeln("Yes");
}