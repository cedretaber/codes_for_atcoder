import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto rs = new int[][N];
    int[] as = [0];
    foreach (i; 1..N) {
        auto a = readln.chomp.to!int-1;
        as ~= a;
        rs[a] ~= i;
    }
    int solve(int i) {
        if (rs[i].empty) return 1;
        int[] cs;
        foreach (j; rs[i]) cs ~= solve(j);
        sort!"a > b"(cs);
        int r;
        foreach (k, c; cs) r = max(r, k.to!int + c + 1);
        return r;
    }
    writeln(solve(0)-1);
}