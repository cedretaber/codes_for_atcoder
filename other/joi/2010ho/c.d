import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    long L = nl[1];
    long[] as = [0];
    foreach (_; 0..N) as ~= readln.chomp.to!long;
    as ~= 0;

    auto DP = new long[](N+2);
    DP[] = -1;
    DP[0] = DP[$-1] = 0;
    long solve(int i) {
        if (DP[i] == -1) {
            long l, r;
            if (as[i-1] > as[i]) l = solve(i-1);
            if (as[i+1] > as[i]) r = solve(i+1);
            DP[i] = L - as[i] + max(l, r);
        }
        return DP[i];
    }
    foreach (i; 1..N+1) if (DP[i] == -1) solve(i);
    writeln(DP[].maxElement);
}