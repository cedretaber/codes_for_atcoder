import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long sum_a, min_a = long.max;
    int mc;
    foreach (a; readln.split.to!(long[])) {
        if (a < 0) ++mc;
        a = abs(a);
        sum_a += a;
        min_a = min(min_a, a);
    }
    writeln(sum_a - (mc%2 == 1 ? min_a*2 : 0));
}