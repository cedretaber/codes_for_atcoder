import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);
    sort(AS);
    sort(BS);
    size_t i, j;
    for (;;) {
        if (j == M) {
            writeln("YES");
            return;
        }
        if (i == N) {
            writeln("NO");
            return;
        }
        if (AS[i] >= BS[j]) {
            ++i;
            ++j;
        } else {
            ++i;
        }
    }
}