import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    auto x = as[0];
    auto y = reduce!"a + b"(0L, as[1..$]);
    auto d = abs(x - y);

    for (int i = 1; i < n-1; ++i) {
        x += as[i];
        y -= as[i];
        auto dd = abs(x - y);
        if (dd < d) d = dd;
    }

    writeln(d);
}