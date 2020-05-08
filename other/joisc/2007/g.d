import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto N = S.length;
    auto cs = new long[](N+1);
    cs[0] = 1;
    foreach (i; 1..N+1) {
        cs[i] = cs[i-1];
        cs[i] *= i.to!long;
    }

    auto s = S.dup.to!(dchar[]);
    sort(s);
    long r;
    foreach (i, c; S) {
        long j;
        foreach (cc; s) {
            if (cc == c) break;
            ++j;
        }
        auto d = cs[N-i-1] * j;
        long[26] ds;
        foreach (cc; s) ++ds[cc - 'A'];
        foreach (dd; ds) d /= cs[dd];
        r += d;
        s = s[0..j] ~ s[j+1..$];
    }
    writeln(r+1);
}