import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nh = readln.split.to!(long[]);
    auto N = nh[0];
    auto H = nh[1];
    auto abcde = readln.split.to!(long[]);
    auto A = abcde[0];
    auto B = abcde[1];
    auto C = abcde[2];
    auto D = abcde[3];
    auto E = abcde[4];

    if (H > E*N) {
        writeln(0);
        return;
    }

    long l, r = C*N;
    while (l+1 < r) {
        auto m = (l+r)/2;
        foreach (a; 0..m/A+1) {
            auto c = (m-a*A)/C;
            auto d = a + c;
            if (H + a*B + c*D > (N-d)*E) goto ok;
        }
        l = m;
        continue;
        ok:
        r = m;
    }
    writeln(r);
}