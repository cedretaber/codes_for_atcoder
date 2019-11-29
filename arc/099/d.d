import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long s(long n)
{
    long r;
    while (n) {
        r += n%10;
        n /= 10;
    }
    return r;
}

double sunuk(long n)
{
    return n.to!double / s(n).to!double;
}

void main()
{
    long[] r;
    foreach (i; 0..15) {
        auto b = 10L^^i;
        foreach (long j; 1..151) {
            r ~= b * j - 1;
        }
    }
    r = r.sort.uniq.array[1..$];
    long[] rr;
    foreach (i, n; r) {
        rr ~= n;
        foreach (m; r[i+1..$]) {
            if (sunuk(n) > sunuk(m)) {
                rr = rr[0..$-1];
                break;
            }
        }
    }

    auto K = readln.chomp.to!int;
    foreach (n; rr[0..K]) {
        writeln(n);
    }
}