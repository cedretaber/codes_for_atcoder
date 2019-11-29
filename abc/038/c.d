import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    int i;
    long s;
    while (i != N) {
        long t = 1, u = 1;
        auto j = i+1;
        while (j < N && as[i] < as[j]) {
            t += (++u);
            ++i; ++j;
        }
        ++i;
        s += t;
    }
    writeln(s);
}