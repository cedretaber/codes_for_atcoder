import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AD = Tuple!(long, "a", bool, "east");

void main()
{
    auto ntq = readln.split.to!(long[]);
    auto N = ntq[0];
    auto T = ntq[1];
    auto Q = ntq[2];

    AD[] AS;
    foreach (_; 0..N) {
        auto ad = readln.split.to!(long[]);
        AS ~= AD(ad[0], ad[1] == 1);
    }

    auto FIX = new bool[](N);
    auto POS = new long[](N);

    void solve(long i) {
        if (i == 0 && !AS[i].east) {
            POS[i] = AS[i].a - T;
        } else if (i == N-1 && AS[i].east) {
            POS[i] = AS[i].a + T;
        } else if (AS[i].east && AS[i+1].east) {
            solve(i+1);
            POS[i] = min(AS[i].a + T, POS[i+1]);
        } else if (!AS[i].east && !AS[i-1].east) {
            POS[i] = max(AS[i].a - T, POS[i-1]);
        } else {
            if (AS[i].a + T >= AS[i+1].a - T) {
                POS[i] = POS[i+1] = (AS[i].a + AS[i+1].a) / 2;
            } else {
                POS[i] = AS[i].a + T;
                POS[i+1] = AS[i+1].a - T;
            }
            FIX[i+1] = true;
        }
        FIX[i] = true;
    }

    foreach (i; 0..N) if (!FIX[i]) solve(i);
    foreach (_; 0..Q) writeln(POS[readln.chomp.to!int-1]);
}