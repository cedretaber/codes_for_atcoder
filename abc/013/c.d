import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nh = readln.split.to!(long[]);
    auto N = nh[0];
    auto H = nh[1];

    auto ae = readln.split.to!(long[]);
    auto A = ae[0];
    auto B = ae[1];
    auto C = ae[2];
    auto D = ae[3];
    auto E = ae[4];

    auto e = E*N-H;
    long r = long.max;

    foreach (i; 0..N+1) {
        auto rr = A * i;
        auto ee = e - (B+E)*i;
        if (ee >= 0) {
            rr += (ee+D+E)/(D+E) * C;
        }
        r = min(r, rr);
    }

    writeln(r);
}