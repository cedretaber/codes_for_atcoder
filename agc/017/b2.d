import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto a = readln.split.to!(long[]);
    auto N = a[0];
    auto A = a[1];
    auto B = a[2];
    auto C = a[3];
    auto D = a[4];

    foreach (i; 0..N-1) {
        auto l = A + C * i - D * (N-i-1);
        auto r = A + D * i - C * (N-i-1);
        if (l <= B && B <= r) {
            writeln("YES");
            return;
        }
    }
    writeln("NO");
}