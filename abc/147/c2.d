import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[][][] MEMO;
    MEMO.length = N;
    foreach (i; 0..N) {
        auto A = readln.chomp.to!int;
        MEMO[i].length = A;
        foreach (j; 0..A) {
            auto xy = readln.split.to!(int[]);
            xy[0] -= 1;
            MEMO[i][j] = xy;
        }
    }

    int r;
    foreach (s; 0..(1<<N)) {
        int c;
        foreach (j; 0..N) if (s & (1<<j)) {
            ++c;
            foreach (xy; MEMO[j]) {
                auto x = xy[0];
                auto y = xy[1];
                if (!!(s & (1<<x)) != !!y) goto ng;
            }
        }
        r = max(r, c);
        ng:
    }
    writeln(r);
}