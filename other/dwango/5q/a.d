import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(double[]);
    auto m = 0.0.reduce!"a + b"(as) / N;
    double max_d = 100;
    size_t s;
    foreach (i, a; as) {
        auto d = (m - a).abs;
        if (d < max_d) {
            max_d = d;
            s = i;
        }
    }
    writeln(s);
}