import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    long x = nx[1];
    auto AS = readln.split.to!(long[]);

    auto min_as = new long[](N);
    min_as[] = long.max;

    auto res = long.max;
    foreach (i; 0..N) {
        long rr = x * i;
        foreach (j; 0..N) {
            min_as[j] = min(min_as[j], AS[(i+j)%N]);
            rr += min_as[j];
        }
        res = min(res, rr);
    }
    writeln(res);
}