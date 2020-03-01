import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] ss, cs;
    foreach (_; 0..M) {
        auto sc = readln.split;
        ss ~= sc[0].to!int-1;
        cs ~= sc[1][0];
    }

    foreach (n; 0..1000) {
        auto x = n.to!string;
        if (x.length != N) continue;
        bool ok = true;
        foreach (i; 0..M) {
            if (x[ss[i]] != cs[i]) {
                ok = false;
                break;
            }
        }
        if (ok) {
            writeln(x);
            return;
        }
    }
    writeln(-1);
}