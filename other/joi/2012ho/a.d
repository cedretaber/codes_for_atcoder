import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto jj = new int[](N);
    auto ii = new int[](N);

    int n;
    foreach (i; 0..N) {
        if (S[i] == 'J') {
            ++n;
        } else {
            n = 0;
        }
        jj[i] = n;
    }
    n = 0;
    foreach_reverse (i; 0..N) {
        if (S[i] == 'I') {
            ++n;
        } else {
            n = 0;
        }
        ii[i] = n;
    }

    int res, j;
    n = 0;
    foreach (i; 1..N) {
        if (S[i] == 'O') {
            if (n == 0) {
                j = i-1;
            }
            ++n;
        } else {
            if (n && jj[j] >= n && ii[i] >= n) {
                res = max(res, n);
            }
            n = 0;
        }
    }
    writeln(res);
}