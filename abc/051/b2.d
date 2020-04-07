import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ks = readln.split.to!(int[]);
    auto K = ks[0];
    auto S = ks[1];
    int r;
    foreach (i; 0..K+1) {
        foreach (j; 0..K+1) {
            auto k = S - i - j;
            if (0 <= k && k <= K) ++r;
        }
    }
    writeln(r);
}