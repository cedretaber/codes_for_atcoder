import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (n; 1..N+1) if (n * (n+1) / 2 == N) {
        writeln("Yes");
        writeln(n+1);
        int[][] res;
        res.length = n+1;
        foreach (ref r; res) r ~= n;
        int x = 1;
        foreach (i; 0..n+1) {
            foreach (j; i+1..n+1) {
                res[i] ~= x;
                res[j] ~= x;
                ++x;
            }
        }
        foreach (r; res) writeln(r.to!(string[]).join(" "));
        return;
    }
    writeln("No");
}