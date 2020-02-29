import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] XS, YS;
    foreach (x; readln.split.to!(int[])) {
        XS ~= x;
        YS ~= x;
    }
    sort(YS);
    auto a = YS[N/2-1], b = YS[N/2];
    foreach (x; XS) {
        if (x <= a) {
            writeln(b);
        } else {
            writeln(a);
        }
    }
}