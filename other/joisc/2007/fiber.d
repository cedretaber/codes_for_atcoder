import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto G = new int[][N];
    auto M = readln.chomp.to!int;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        G[B] ~= A;
    }

    int c;
    auto MEMO = new int[](N);
    foreach (n; 0..N) if (MEMO[n] == 0) {
        ++c;
        void walk(int i) {
            MEMO[i] = c;
            foreach (j; G[i]) if (MEMO[j] == 0) walk(j);
        }
        walk(n);
    }
    writeln(c-1);
}