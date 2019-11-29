import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;


void main()
{
    auto nd = readln.split.to!(long[]);
    auto N = nd[0];
    auto A = nd[1];
    auto B = nd[2];
    auto C = nd[3];
    auto D = nd[4];

    foreach (m; 0..N-1) {
        if (C * (N-1-m) - D*m <= B-A && B-A <= D * (N-1-m) - C*m) {
            writeln("YES");
            return;
        }
    }
    writeln("NO");
}