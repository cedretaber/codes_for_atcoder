import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum n2m = [-1,2,5,5,4,5,6,3,7,6];
enum ns = [2,3,4,5,6,7];

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ms = new int[](10);
    ms[] = 10;
    foreach (a; readln.split.to!(int[])) if (ms[n2m[a]] > a) ms[n2m[a]] = a;

    auto rs = new int[](10);
    bool solve(int i, int n) {
        if (i == ns.length) return n == 0;
        if (ms[ns[i]] == 10) return solve(i+1, n);

        foreach_reverse (j; 0..n/ns[i]+1) {
            if (n - ns[i]*j < 0) continue;
            rs[ns[i]] = j;
            auto ret = solve(i+1, n - ns[i]*j);
            if (ret) return true;
            rs[ns[i]] = 0;
        }
        return false;
    }
    solve(0, N);

    char[] res;
    foreach_reverse (n; 1..10) if (ms[n2m[n]] == n) {
        foreach (_; 0..rs[n2m[n]]) res ~= '0' + n.to!char;
    }
    writeln(res);
}