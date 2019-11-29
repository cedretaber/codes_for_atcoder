import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long[][10^^5] T;
long[10^^5] D;
bool[10^^5] M;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(long[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }

    long r = 1;
    long[] ss = [0];
    M[0] = true;
    while (!ss.empty) {
        auto i = ss[0];
        ss = ss[1..$];
        auto ir = K - D[i];
        foreach (j; T[i]) {
            if (!M[j]) {
                ss ~= j;
                M[j] = true;
            }
            ir -= D[j];
            ++D[j];
        }
        r = (r * ir) % P;
    }
    writeln(r);
}