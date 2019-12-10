import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    long solve(size_t i, long sum) {
        if (i == S.length) return sum;
        long r;
        foreach (j; i+1..S.length+1) {
            r += solve(j, sum + S[i..j].to!long);
        }
        return r;
    }
    writeln(solve(0, 0));
}