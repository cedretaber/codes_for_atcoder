import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[51][51] GF;
int[51] NS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 1..M+1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0];
        auto B = ab[1];
        GF[A][B] = i;
        GF[B][A] = i;
    }

    int cnt;
    foreach (i; 1..M+1) {
        void solve(int p) {
            if (NS[p] == i) return;
            NS[p] = i;
            foreach (j, n; GF[p][1..N+1]) if (n && n != i) solve((j+1).to!int);
        }
        solve(1);
        foreach (n; NS[1..N+1]) if (n != i) {
            ++cnt;
            break;
        }
    }
    writeln(cnt);
}