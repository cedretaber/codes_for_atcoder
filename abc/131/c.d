import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto l = readln.split.to!(long[]);
    auto A = l[0];
    auto B = l[1];
    auto C = l[2];
    auto D = l[3];

    auto n = B/C + B/D - B/(C*D/gcd(C,D));
    auto m = (A-1)/C + (A-1)/D - (A-1)/(C*D/gcd(C,D));
    writeln((B-A+1) - (n-m));
}