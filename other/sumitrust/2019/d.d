import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    auto ls = new bool[][](N, 10);
    auto rs = new bool[][](N, 10);
    foreach (i; 0..N) {
        if (i != 0) {
            foreach (j; 0..10) {
                ls[i][j] = ls[i-1][j];
            }
        }
        ls[i][S[i] - '0'] = true;
    }
    foreach_reverse (i; 0..N) {
        if (i != N-1) {
            foreach (j; 0..10) {
                rs[i][j] = rs[i+1][j];
            }
        }
        rs[i][S[i] - '0'] = true;
    }
    auto rr = new bool[](1000);
    foreach (i; 1..N-1) {
        foreach (a; 0..10) foreach (c; 0..10) {
            if (ls[i-1][a] && rs[i+1][c]) rr[a*100 + (S[i] - '0')*10 + c] = true;
        }
    }
    int res;
    foreach (i, r; rr) if (r) {
        ++res;
    }
    writeln(res);
}