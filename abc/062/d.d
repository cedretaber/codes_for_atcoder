import std.stdio, std.algorithm, std.conv, std.array, std.string;

long[long][10^^5*3+1] MEMO;
void main()
{
    auto n = readln.chomp.to!long;
    auto ns = readln.split.to!(long[]);
    auto n3 = n*3;

    long solve(long i, long x) {
        if (x in MEMO[i]) return MEMO[i][x];
        if (i == n3) return MEMO[i][x] = 0;

        return MEMO[i][x] = x <= n ?
            max(
                (n3-i) > x ? solve(i+1, x) : long.min,
                x > 0 ? solve(i+1, x-1) - ns[i] : long.min
            )
        :
            max(
                (n3-i) > x ? solve(i+1, x) : long.min,
                x > 0 ? solve(i+1, x-1) + ns[i] : long.min
            );
    }

    writeln(solve(0, n*2));
}