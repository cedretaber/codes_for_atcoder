import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Dist = Tuple!(int, "n", int, "d");

Dist[][100_001] DS;
int[100_001] NS;
bool[100_001] BS;

void main()
{
    int N, M, L, R, D;
    readf("%d %d", &N, &M);
    foreach (i; 1..M+1) {
        readf(" %d %d %d", &L, &R, &D);
        DS[L] ~= Dist(R, D);
        DS[R] ~= Dist(L, -D);
    }

    bool check(int i, int org, int d) {
        if (!BS[i]) {
            BS[i] = true;
            NS[i] = NS[org] + d;
        } else if (NS[i] != NS[org] + d) return false;

        while (!DS[i].empty) {
            auto head = DS[i][0];
            DS[i] = DS[i][1..$];
            if (head.n != org && !check(head.n, i, head.d)) return false;
        }
        return true;
    }

    for (int start = 1; start <= N; ++start) {
        if (BS[start]) continue;
        if (!DS[start].empty && !check(start, 0, 0)) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}