import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

static immutable PS = [
2,
4,
8,
16,
32,
64,
128,
256,
512,
1024,
2048,
4096,
8192,
16384,
32768,
65536,
131072,
262144,
524288,
1048576,
2097152,
4194304,
8388608,
16777216,
33554432,
67108864,
134217728,
268435456,
536870912,
1073741824
];

int bsearch(int n, int[] hs)
{
    int min_p = 0, max_p = hs.length.to!int, last = -1;
    if (min_p == max_p) return -1;
    for (;;) {
        auto mid_p = (min_p + max_p) / 2;
        if (mid_p == last) break;
        auto t = hs[mid_p];
        if (t == n) {
            return mid_p;
        } else if (t < n) {
            min_p = mid_p;
        } else {
            max_p = mid_p;
        }
        last = mid_p;
    }
    return -1;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    sort(AS);

    size_t[][int] pos;
    foreach (i, a; AS) {
        if (a !in pos) {
            pos[a] = [i];
        } else {
            pos[a] ~= i;
        }
    }

    int cnt;
    while (!AS.empty) {
        auto a = AS[0];
        AS = AS[1..$];
        foreach_reverse (p; PS) {
            if (p < a) break;
            auto b = p - a;
            auto i = bsearch(b, AS);
            if (i != -1) {
                ++cnt;
                AS = AS[0..i] ~ AS[i+1..$];
            }
        }
    }
    writeln(cnt);
}