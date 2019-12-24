import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

char[][] transpose(char[][] s) {
    auto h = s.length;
    auto w = s[0].length;
    auto t = new char[][](h, w);
    foreach (i; 0..h) {
        foreach (j; 0..w) {
            t[j][w-i-1] = s[i][j];
        }
    }
    return t;
}

void main()
{
    auto N = readln.chomp.to!int;
    char[][] s, t;
    s.length = N;
    t.length = N;
    foreach (i; 0..N) s[i] = readln.chomp.to!(char[]);
    foreach (i; 0..N) t[i] = readln.chomp.to!(char[]);

    int cnt(char[][] s) {
        int c;
        foreach (i; 0..s.length) {
            foreach (j; 0..s[0].length) {
                if (s[i][j] != t[i][j]) ++c;
            }
        }
        return c;
    }

    auto r = cnt(s);
    s = transpose(s);
    r = min(r, cnt(s) + 1);
    s = transpose(s);
    r = min(r, cnt(s) + 2);
    s = transpose(s);
    r = min(r, cnt(s) + 1);
    writeln(r);
}