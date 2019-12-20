import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nl = readln.split.to!(long[]);
    auto N = nl[0];
    auto L = nl[1];
    auto xs = new long[](N);
    foreach (i; 0..N) xs[N-i-1] = readln.chomp.to!long;

    long x = xs[0], y = xs[0], l = long.max;
    foreach (z; xs[1..$]) {
        if (x - z < L) {
            y = z;
            continue;
        }
        if (y + L*2 <= l) {
            l = y;
        } else {
            l = l - L*2;
        }
        if (z + L >= l) {
            writeln("NO");
            return;
        }
        x = y = z;
    }
    writeln(y+L*2 <= l || l-L*2 > 0 ? "YES" : "NO");
}