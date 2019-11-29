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

alias U = Tuple!(long, "a", long, "b");

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    long[long] memo;
    foreach (a; AS) {
        if (a in memo) {
            ++memo[a];
        } else {
            memo[a] = 1;
        }
    }

    U[] us;
    foreach (a; AS) {
        if (!memo[a]) continue;
        --memo[a];
        foreach_reverse (p; PS) {
            if (p < a) break;
            auto b = p - a;
            if (b in memo && memo[b]) {
                us ~= U(a, b);
            }
        }
    }
    writeln(us);
}


/*

3 11 14 5 13
3 5 11 13 14

3 - 5
|   |
13  11

3 5 13 19

3 - 5
|
13 - 19

*/