import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[301] NS;

void main()
{
    auto N = readln.chomp.to!int;
    auto NG1 = readln.chomp.to!int;
    auto NG2 = readln.chomp.to!int;
    auto NG3 = readln.chomp.to!int;

    NS[] = 101;
    NS[N] = 0;
    foreach_reverse (n; 1..N+1) {
        if (n == NG1 || n == NG2 || n == NG3 || NS[n] == 101) continue;
        if (n-1 >= 0) NS[n-1] = min(NS[n-1], NS[n] + 1);
        if (n-2 >= 0) NS[n-2] = min(NS[n-2], NS[n] + 1);
        if (n-3 >= 0) NS[n-3] = min(NS[n-3], NS[n] + 1);
    }
    writeln(NS[0] <= 100 ? "YES" : "NO");
}