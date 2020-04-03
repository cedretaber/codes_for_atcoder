import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    long[] ns;
    foreach (k; 3..10) {
        foreach (x; 0..3^^k) {
            int a, b, c;
            long n;
            foreach (_; 0..k) {
                n *= 10;
                if (x%3 == 0) {
                    n += 3;
                    ++a;
                } else if (x%3 == 1) {
                    n += 5;
                    ++b;
                } else {
                    n += 7;
                    ++c;
                }
                x /= 3;
            }
            if (a && b && c) ns ~= n;
        }
    }
    sort(ns);
    auto N = readln.chomp.to!long;
    int i;
    while (i < ns.length && ns[i] <= N) ++i;
    writeln(i);
}