import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = new long[](N*2);
    foreach (i; 0..N) {
        auto a = readln.chomp.to!long;
        AS[i] = a;
        AS[N+i] = a;
    }

    auto cs = new long[](N*2);
    foreach (i; 0..N*2) {
        if (i) cs[i] = cs[i-1];
        cs[i] += AS[i%N];
    }

    long max_a;
    int i, j;
    while (i < N) {
        if (i > j) {
            ++j;
            continue;
        }
        auto a = cs[j] - (i ? cs[i-1] : 0);
        if (cs[j+1] - cs[j] >= a && cs[N+i-1] - cs[j+1] >= a) {
            max_a = max(max_a, a);
            ++j;
            continue;
        } else if (cs[N+i-2] - cs[j] < a) {
            ++i;
            continue;
        }
        auto l = j+1, r = N+i-2;
        while (l+1 < r) {
            auto m = (l+r)/2;
            auto b = cs[m] - cs[j];
            if (b >= a) {
                r = m;
            } else {
                l = m;
            }
        }
        if (cs[N+i-1] - cs[r] >= a) {
            max_a = max(max_a, a);
            ++j;
        } else {
            ++i;
        }
    }
    writeln(max_a);
}