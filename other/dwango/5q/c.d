import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto Q = readln.chomp.to!int;
    auto ks = readln.split.to!(int[]);

    auto ms = new long[](N);
    auto cs = new long[](N);
    size_t[] dis, cis;
    long m, c;
    foreach (i, s; S) {
        if (s == 'M') ++m;
        ms[i] = m;
        if (s == 'D') {
            dis ~= i;
        }
        if (s == 'C') {
            cis ~= i;
            c++;
        }
        cs[i] = c;
    }
    auto cms = new long[](N);
    long last;
    foreach (i, s; S) if (s == 'D' || s == 'C') {
        if (s == 'C') last += ms[i];
        cms[i] = last;
    }

    foreach (k; ks) {
        long res;
        size_t ci;
        foreach (i; dis) {
            while (ci < cis.length && cis[ci] < i) ++ci;
            if (ci == cis.length) break;
            if (cis[ci] - i >= k) continue;
            size_t l = ci, r = cis.length-1;
            if (cis[$-1] - i < k) {
                l = r;
            } else {
                while (l+1 < r) {
                    m = (l+r)/2;
                    if (cis[m] - i >= k) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
            }
            auto j = cis[l];
            res += cms[j] - cms[i] - ms[i] * (cs[j] - cs[i]);
        }
        writeln(res);
    }
}