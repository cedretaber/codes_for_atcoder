import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias P = Tuple!(int, int);

void main()
{
    int[9] bb, cc;
    foreach (i, b; readln.split.to!(int[])) bb[i] = b;
    foreach (i, b; readln.split.to!(int[])) bb[3+i] = b;
    foreach (i, c; readln.split.to!(int[])) cc[i] = c;
    foreach (i, c; readln.split.to!(int[])) cc[3+i] = c;
    foreach (i, c; readln.split.to!(int[])) cc[6+i] = c;

    auto DP = new P[](3^^9);
    auto NONE = P(-1, -1);
    DP[] = NONE;
    int[9] B;
    P solve() {
        uint s;
        int a, b;
        foreach (i; 0..9) {
            if (B[i] == 1) {
                ++a;
            } else if (B[i] == 2) {
                ++b;
            }
            s *= 3;
            s += B[i];
        }
        
        if (a+b == 9) {
            a = 0; b = 0;
            foreach (i; 0..8) {
                if (i/3 < 2) {
                    if (B[i] == B[3+i]) {
                        a += bb[i];
                    } else {
                        b += bb[i];
                    }
                }
                if (i%3 < 2) {
                    if (B[i] == B[i+1]) {
                        a += cc[i];
                    } else {
                        b += cc[i];
                    }
                }
            }
            return P(a, b);
        } else if (DP[s] == NONE) {
            auto r = NONE;
            foreach (i; 0..9) if (B[i] == 0) {
                B[i] = a == b ? 1 : 2;
                auto rr = solve();
                if ((a == b && rr[0] > r[0]) || (a != b && rr[1] > r[1])) r = rr;
                B[i] = 0;
            }
            DP[s] = r;
        }
        return DP[s];
    }
    auto r = solve();
    writeln(r[0], "\n", r[1]);
}