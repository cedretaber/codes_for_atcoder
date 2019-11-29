import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][100_000] Tree;
int[int][100_000] Path;

void main()
{
    auto n = readln.chomp.to!int;
    foreach (i; 0..n) Path[i] = -1;
    foreach (_; 0..n-1) {
        auto abt = readln.split.to!(int[]);
        auto a = abt[0] - 1;
        auto b = abt[1] - 1;
        auto t = abt[2];
        Tree[a] ~= b;
        Path[a][b] = -1;
        if (t == 2) {
            Tree[b] ~= a;
            Path[b][a] = -1;
        }
    }

    int solve(int i) {
        if (Path[i] != -1) return Path[i] + 1;
        auto x = -1;
        Path[i] = -2;
        foreach (j; Tree[i]) x = max(x, solve(j));
        Path[i] = x;
        return x + 1;
    }

    foreach (i; 0..n) solve(i);
    writeln(Path[0..n]);
    sort!"a > b"(Path[0..n]);
    writeln(Path[0]);
}