import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmab = readln.split.to!(int[]);
    auto N = nmab[0];
    auto M = nmab[1];
    auto A = nmab[2];
    auto B = nmab[3];

    auto ms = new int[](N);
    foreach (_; 0..M) {
        auto lr = readln.split.to!(int[]);
        auto L = lr[0]-1;
        auto R = lr[1];
        ++ms[L];
        if (R < N) --ms[R];
    }
    int r, s;
    foreach (m; ms) {
        s += m;
        r += s == 0 ? B : A;
    }
    writeln(r);
}