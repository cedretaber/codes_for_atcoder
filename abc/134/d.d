import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5*2+1] M;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    foreach_reverse (ii, a; as) {
        auto i = ii.to!int + 1;
        int cnt;
        for (int j = i; j <= N; j += i) cnt = (cnt + M[j]) % 2;
        if (a != cnt) M[i] = 1;
    }

    int[] rr;
    foreach (i, m; M[1..$]) if (m) rr ~= i.to!int + 1;
    writeln(rr.length);
    writeln(rr.to!(string[]).join(" ")); 
}