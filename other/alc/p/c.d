import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

long floorSum(long n, long m, long a, long b)
{
    long ans;
    if (m <= a)
    {
        ans += (n - 1) * n * (a / m) / 2;
        a %= m;
    }
    if (m <= b)
    {
        ans += n * (b / m);
        b %= m;
    }
    long y_max = (a * n + b) / m, x_max = (y_max * m - b);
    if (y_max == 0)
        return ans;
    ans += (n - (x_max + a - 1) / a) * y_max;
    ans += floorSum(y_max, a, m, (a - x_max % a) % a);
    return ans;
}

void main()
{
    auto T = readln.chomp.to!int;
    while (T--) {
        auto nmab = readln.split.to!(long[]);
        writeln(floorSum(nmab[0], nmab[1], nmab[2], nmab[3]));
    }
}