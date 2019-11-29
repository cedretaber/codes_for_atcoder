import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[102][102] GP;
bool[102] FS;

void main()
{
    auto nge = readln.split.to!(int[]);
    auto N = nge[0];
    auto G = nge[1];
    auto E = nge[2];
    auto ps = readln.split.to!(int[]);

    foreach (_; 0..E) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0];
        auto b = ab[1];
        GP[a][b] = 1;
        GP[b][a] = 1;
    }

    foreach (p; ps) {
        GP[p][N+1] = 1;
    }

    int solve(int i) {
        if (i == N+1) return 1;
        foreach (j; 1..N+2) if (FS[j] && GP[i][j]) {
            FS[j] = false;
            if (solve(j)) {
                --GP[i][j];
                ++GP[j][i];
                return 1;
            } else
                FS[j] = false;
        }
        return 0;
    }

    FS[] = true;
    int r;
    while (solve(0)) {
        ++r;
        FS[] = true;
    }
    writeln(r);
}