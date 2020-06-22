import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    if (S.length == 2) {
        if (S[0] == '0' || S[1] == '1') {
            writeln(-1);
        } else {
            writeln("1 2");
        }
        return;
    }
    if (S[0] == '0' || S[$-2] == '0' || S[$-1] == '1') {
        writeln(-1);
        return;
    }

    int[] as, bs;
    int p = 1;
    auto N = S.length.to!int;
    int i, j = N-2;
    while (i <= j) {
        if (S[i] != S[j]) {
            writeln(-1);
            return;
        }
        as ~= p;
        bs ~= i+2;
        if (S[i] == '1') p = i+2;
        ++i; --j;
    }
    for (; i < N-1; ++i) {
        as ~= p;
        bs ~= i+2;
    }
    foreach (k; 0..N-1) writeln(as[k], " ", bs[k]);
}