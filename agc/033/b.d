import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5*2+2] LR, DU;

void main()
{
    auto hwn = readln.split.to!(int[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];
    auto rc = readln.split.to!(int[]);
    auto SR = rc[0];
    auto SC = rc[1];
    auto S = readln.chomp.to!(char[]);
    auto T = readln.chomp.to!(char[]);

    int a, b, c, d;

    a = 0, b = SC, c = SC, d = W+1;
    foreach (i; 0..N) {
        if (S[i] == 'L') {
            ++a;
        } else if (S[i] == 'R') {
            --d;
        }
        if (a == c || b == d || a+1 == d) {
            writeln("NO");
            return;
        }
        if (T[i] == 'L') {
            if (d <= W) {
                ++d;
            } else if (b > 0) {
                --b;
            }
        } else if (T[i] == 'R') {
            if (a > 0) {
                --a;
            } else if (c <= W) {
                ++c;
            }
        }
    }

    a = 0, b = SR, c = SR, d = H+1;
    foreach (i; 0..N) {
        if (S[i] == 'U') {
            ++a;
        } else if (S[i] == 'D') {
            --d;
        }
        if (a == c || b == d || a+1 == d) {
            writeln("NO");
            return;
        }
        if (T[i] == 'U') {
            if (d <= W) {
                ++d;
            } else if (b > 0) {
                --b;
            }
        } else if (T[i] == 'D') {
            if (a > 0) {
                --a;
            } else if (c <= W) {
                ++c;
            }
        }
    }

    writeln("YES");
}