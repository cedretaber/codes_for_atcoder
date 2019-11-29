import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[][100] T;
bool[100] H;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto n = nx[0];
    auto x = nx[1]-1;

    foreach (i, h; readln.split.to!(int[])) H[i] = h == 1;
    foreach (_; 0..n-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }

    int s(int i, int p) {
        int y;
        foreach (j; T[i]) if (j != p) {
            y += s(j, i);
        }
        if (y != 0 || H[i]) y += 2;
        return y;
    }
    int z;
    foreach (i; T[x]) z += s(i, x);

    writeln(z);
}