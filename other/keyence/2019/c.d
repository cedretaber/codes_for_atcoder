import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] AS, BS, DS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i, a; readln.split.to!(long[])) AS[i] = a;
    foreach (i, b; readln.split.to!(long[])) BS[i] = b;

    long O, L, cnt;
    foreach (i; 0..N) {
        auto d = AS[i] - BS[i];
        DS[i] = d;
        if (d > 0) {
            O += d;
        } else if (d < 0) {
            L -= d;
            ++cnt;
        }
    }
    if (L > O) {
        writeln("-1");
        return;
    }
    sort!"a > b"(DS[0..N]);
    foreach (d; DS) {
        if (L <= 0) break;
        L -= d;
        ++cnt;
    }
    writeln(cnt);
}