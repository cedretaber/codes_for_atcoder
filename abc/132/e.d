import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] G;
bool[3][10^^5] F;

alias S = Tuple!(int, "p", int, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto uv = readln.split.to!(int[]);
        G[uv[0]-1] ~= uv[1]-1;
    }
    auto st = readln.split.to!(int[]);
    auto S = st[0]-1;
    auto T = st[1]-1;

    auto ss = [S];
    F[S][0] = true;
    int c;
    while (!ss.empty) {
        ++c;
        int[] nss;
        foreach (s; ss) {
            foreach (n; G[s]) {
                if (F[n][c%3]) continue;
                F[n][c%3] = true;
                if (c % 3 == 0 && n == T) {
                    writeln(c/3);
                    return;
                }
                nss ~= n;
            }
        }
        ss = nss;
    }
    writeln(-1);
}