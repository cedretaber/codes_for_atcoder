import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto G = new int[][N];
    foreach (_; 0..N) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0]-1;
        auto y = xy[1]-1;
        G[x] ~= y;
        G[y] ~= x;
    }

    auto memo = new int[](N);
    memo[] = -1;

    int walk(int i, int p, int l) {
        if (memo[i] != -1) {
            return l - memo[i];
        } else {
            memo[i] = l;
            foreach (j; G[i]) if (j != p) {
                auto s = walk(j, i, l+1);
                if (s != -1) return s;
            }
            return -1;
        }
    }
    writeln(walk(0, -1, 0));
}