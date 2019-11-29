import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias S = Tuple!(int, "i", int, "c", int[], "hs");

string[1002] DS;
int[][1002] G;

void main()
{
    auto fl = readln.split;
    auto first = fl[0];
    auto last = fl[1];
    auto N = readln.chomp.to!int;
    DS[0] = first;
    DS[N+1] = last;
    foreach (i; 0..N) {
        DS[i+1] = readln.chomp;
    }

    if (first == last) {
        writeln(0);
        writeln(first);
        writeln(last);
        return;
    }

    auto l = first.length;
    foreach (i; 0..N+1) {
        foreach (j; i+1..N+2) {
            int c;
            foreach (k; 0..l) {
                if (DS[i][k] != DS[j][k]) ++c;
                if (c > 2) break;
            }
            if (c == 1) {
                G[i] ~= j;
                G[j] ~= i;
            }
        }
    }

    auto ss = [S(0, 0, [])];
    S xs;
    bool[] F;
    F.length = N+2;
    F[0] = true;
    int c;
    while (!ss.empty) {
        auto s = ss[0];
        ss = ss[1..$];
        foreach (j; G[s.i]) {
            if (F[j]) continue;
            if (j == N+1) {
                xs = S(N+1, s.c, s.hs[1..$] ~ s.i);
                goto ok;
            }
            F[j] = true;
            ss ~= S(j, s.c+1, s.hs ~ s.i);
        }
    }
    writeln("-1");
    return;
    ok:
    writeln(xs.c);
    writeln(first);
    foreach (i; xs.hs) {
        writeln(DS[i]);
    }
    writeln(last);
}