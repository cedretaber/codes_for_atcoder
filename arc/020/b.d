import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[100] as;

void main()
{
    auto nc = readln.split.to!(int[]);
    auto n = nc[0];
    auto c = nc[1];
    foreach (i; 0..n) as[i] = readln.chomp.to!int;

    auto r = int.max;
    foreach (i; 1..11) {
        foreach (j; 1..11) {
            if (i == j) continue;
            int rr;
            foreach (k, a; as[0..n]) {
                if (k%2 == 0) {
                    if (a != i) ++rr;
                } else {
                    if (a != j) ++rr;
                }
            }
            r = min(r, rr);
        }
    }
    writeln(r * c);
}