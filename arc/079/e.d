import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    long r;
    for (;;) {
        bool flg;
        foreach (i, ref a; as) {
            if (a >= N) {
                flg = true;
                auto n = a / N;
                r += n;
                a = a % N;
                foreach (j, ref aa; as) {
                    if (i == j) continue;
                    aa += n;
                }
            }
        }
        if (!flg) break;
    }
    writeln(r);
}