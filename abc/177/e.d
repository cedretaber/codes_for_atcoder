import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    auto ps = new int[](10^^6+1);
    foreach (a; AS) {
        for (int i = 2; i^^2 <= a; ++i) {
            if (a%i == 0) {
                ps[i] += 1;
                while (a%i == 0) a /= i;
            }
        }
        if (a != 1) ps[a] += 1;
    }

    auto pc = true;
    foreach (p; ps) {
        if (p == N) {
            writeln("not coprime");
            return;
        } else if (p > 1) {
            pc = false;
        }
    }
    writeln(pc ? "pairwise coprime" : "setwise coprime");
}