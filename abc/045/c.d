import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto s = readln.chomp;
    auto len = s.length;

    long[string][11] memo;
    long solve(size_t i, char[][] acm) {
        auto key = acm.to!string;
        if (key in memo[i]) return memo[i][key];

        long ret;
        if (i == len) {
            ret = acm.dup.map!(to!long).reduce!"a+b";
        } else {
            ret = solve(i+1, acm[0..$-1] ~ (acm[$-1] ~ s[i])) + solve(i+1, acm ~ [s[i]]);
        }
        return memo[i][key] = ret;
    }

    writeln(solve(1UL, [[s[0]]]));
}