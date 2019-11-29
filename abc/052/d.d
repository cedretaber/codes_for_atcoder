import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto a = nab[1];
    auto b = nab[2];
    auto xs = readln.split.to!(long[]);

    long ret, pos = xs[0];
    foreach (x; xs[1..$]) {
        auto d = (x - pos) * a;
        if (d > b) {
            ret += b;
            pos = x;
        } else {
            ret += d;
            pos = x;
        }
    }
    writeln(ret);
}