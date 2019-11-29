import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto cs = readln.chomp.to!(char[]);

    auto abxy = "ABXY";

    int r = int.max;
    foreach (l1; abxy) {
        foreach (l2; abxy) {
            foreach (r1; abxy) {
                foreach (r2; abxy) {
                    if (l1 == r1 && l2 == r2) continue;
                    int rr;
                    for (size_t i; i < N; ++i) {
                        ++rr;
                        if (i+1 < N) if ((cs[i] == l1 && cs[i+1] == l2) || (cs[i] == r1 && cs[i+1] == r2)) ++i;
                    }
                    r = min(r, rr);
                }
            }
        }
    }
    writeln(r);
}