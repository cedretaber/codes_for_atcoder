import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    char[19][19] B;
    int b, w;
    static foreach (i; 0..19) {
        foreach (j, c; readln.chomp.to!(char[])) {
            B[i][j] = c;
            switch (c) {
                case 'o': ++b; break;
                case 'x': ++w; break;
                default:
            }
        }
    }

    if (b == 0 && w == 0) {
        writeln("YES");
        return;
    }

    char last;
    if (b-w == 1) {
        last = 'o';
    } else if (b-w == 0) {
        last = 'x';
    } else {
        writeln("NO");
        return;
    }

    foreach (i; 0..19)
    foreach (j; 0..19)
    if (B[i][j] == last) {
        B[i][j] = '.';
        bool[4][19][19] memo;
        int max_len;
        static foreach (idx, d; [[1,0], [0,1], [1,1], [1,-1]])
        foreach (k; 0..19)
        foreach (l; 0..19)
        if (B[k][l] != '.' && !memo[i][j][idx]) {
            int len, m = k, n = l;
            while (m >= 0 && m < 19 && n >= 0 && n < 19 && B[m][n] == B[k][l]) {
                memo[m][n][idx] = true;
                m += d[0];
                n += d[1];
                ++len;
            }
            max_len = max(max_len, len);
        }
        if (max_len < 5) goto ok;
        B[i][j] = last;
    }
    writeln("NO");
    return;
    ok:
    writeln("YES");
}