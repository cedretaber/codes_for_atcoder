import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

int[][] read_tree_without_cost(int N) {
    auto T = new int[][N];
    foreach (i; 1..N) {
        auto j = readln.chomp.to!int;
        T[i] ~= j;
        T[j] ~= i;
    }
    return T;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto T = read_tree_without_cost(N);

    auto rs = new int[](N);
    int solve(int i, int p) {
        int max_b, s;
        foreach (j; T[i]) if (j != p) {
            auto b = solve(j, i);
            max_b = max(max_b, b);
            s += b;
        }
        rs[i] = max(max_b, N-s-1);
        return s+1;
    }
    solve(0, -1);
    foreach (ref r; rs) writeln(r);
}