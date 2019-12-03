import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!long;
    auto s = readln.chomp.to!long;

    long b = 2;
    for (; b^^2 <= n; ++b) {
        auto m = n;
        long t;
        while (m) {
            t += m % b;
            m /= b;
        }
        if (t == s) {
            writeln(b);
            return;
        }
    }
    auto x = n/(b-1);
    for (; x > 0; --x) {
        auto y = s - x;
        if (y < 0) continue;
        b = (n-y)/x;
        if (n-y >= 0 && (n-y)%x == 0 && b > 1 && n%b + (n/b)%b == s) {
            writeln(b);
            return;
        }
    }
    if (s == n) {
        writeln(n+1);
        return;
    }
    writeln(-1);
}