import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    auto ntoi = new int[](N+1);
    foreach (i, a; as) {
        ntoi[a] = i.to!int;
    }
    int i;
    int k = N;
    for (;;) {
        while (i < N && as[i] == i+1) ++i;
        if (i == N) break;
        --k;
        ntoi[as[i]] = ntoi[i+1];
        as[ntoi[i+1]] = as[i];
        as[i] = i+1;
    }
    writeln(k%2 == 0 ? "YES" : "NO");
}