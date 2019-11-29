import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

ulong[50] solve(ulong x)
{
    ulong[50] r;
    auto y = x;

    size_t i;
    while (y > 0) {
        r[i] = x / 2^^(i+1) * 2^^i;
        if (x % 2^^(i+1) >= 2^^i) r[i] += x % 2^^(i+1) + 1 - 2^^i;
        ++i;
        y >>= 1;
    }

    return r;
}

void main()
{
    auto ab = readln.split.to!(ulong[]);
    auto A = ab[0];
    auto B = ab[1];

    if (A == 0) {
        ulong r, j = 1;
        foreach (i, x; solve(B)) {
            if (x % 2 == 1) r |= (j<<i);
        }
        writeln(r);
        return;
    }

    auto a = solve(A-1);
    auto b = solve(B);
    ulong r, j = 1;
    foreach (i; 0..50) {
        if ((b[i] - a[i]) % 2 == 1) {
            r |= (j<<i);
        }
    }
    writeln(r);
}