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
1073741824,
2147483648
];

int[long] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    sort(AS);
    foreach (a; AS) {
        if (a in MEMO) {
            ++MEMO[a];
        } else {
            MEMO[a] = 1;
        }
    }

    int cnt;
    foreach_reverse (a; AS) {
        if (!MEMO[a]) continue;
        --MEMO[a];
        foreach (p; PS) {
            auto b = p - a;
            if (b < 0 || b > a) continue;
            if (b in MEMO && MEMO[b]) {
                --MEMO[b];
                ++cnt;
            }
        }
    }

    writeln(cnt);
}