import std.stdio, std.conv, std.string, std.array, std.algorithm, std.math;

void main()
{
    auto ns = readln.chomp;
    auto ret = ns.count;
    auto n = ns.to!ulong;

    for (ulong a = 2; a^^2 <= n; ++a) {
        if (n%a) continue;

        auto b = n/a;
        int i = 1;
        for (; b > 9; ++i) b /= 10;

        if (i < ret) ret = i;
    }

    writeln(ret);
}