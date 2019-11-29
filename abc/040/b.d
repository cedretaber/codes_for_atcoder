import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!int;

    int r = int.max;
    for (int i = 1; i^^2 <= n; ++i) {
        auto j = n/i;
        auto d = n - i*j;
        r = min(r, abs(i-j)+d);
    }
    writeln(r);
}