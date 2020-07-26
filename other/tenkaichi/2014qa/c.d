import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    string[] ps;
    foreach (_; 0..N) ps ~= readln.chomp;

    auto T = new bool[][](N, N);
    foreach (ref t; T) t[] = true;
    foreach (i; 0..M) {
        foreach (j; 0..N-1) {
            if (ps[j][i] == '*') continue;
            foreach (k; j+1..N) {
                if (ps[k][i] != '*' && ps[j][i] != ps[k][i]) {
                    T[j][k] = false;
                    T[k][j] = false;
                }
            }
        }
    }

    auto cs = new bool[](1<<N);
    foreach (b; 0..(1<<N)) {
        foreach (i; 0..N-1) if (b & (1<<i)) {
            foreach (j; i+1..N) if (b & (1<<j)) {
                if (!T[i][j]) goto ng;
            }
        }
        cs[b] = true;
        ng:
    }
    
    auto bs = new uint[](N);
    int solve(int i, int l) {
        if (i == N) {
            foreach (b; bs[0..l]) if (!cs[b]) return N;
            return l;
        } else {
            auto r = N;
            foreach (j; 0..l) {
                auto pb = bs[j];
                bs[j] |= (1<<i);
                r = min(r, solve(i+1, l));
                bs[j] = pb;
            }
            bs[l] = 1<<i;
            return min(r, solve(i+1, l+1));
        }
    }
    writeln(solve(0, 0));
}