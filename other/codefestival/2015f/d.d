import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = new int[](10^^5);
    int[] SS, TS;
    foreach (_; 0..N) {
        auto st = readln.split.to!(int[]);
        auto S = st[0]-1;
        auto T = st[1]-1;
        SS ~= S;
        TS ~= T;
        ++cs[S];
        if (T < 10^^5) --cs[T];
    }
    int max_c;
    foreach (i; 0..10^^5-1) {
        cs[i+1] += cs[i];
        max_c = max(max_c, cs[i]);
    }
    size_t ft, lt;
    bool ff;
    foreach (i, c; cs) if (c == max_c) {
        if (!ff) {
            ft = i;
            ff = true;
        }
        lt = i;
    }
    bool ok;
    foreach (i; 0..N) if (SS[i] <= ft && lt < TS[i]) {
        ok = true;
        break;
    }
    writeln(max_c - (ok ? 1 : 0));
}