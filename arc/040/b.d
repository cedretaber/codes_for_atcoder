import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nr = readln.split.to!(int[]);
    auto N = nr[0];
    auto R = nr[1];
    auto S = readln.chomp.to!(char[]);

    int r;
    foreach (c; S) if (c == '.') ++r;
    int x;
    void paint(int i) {
        ++x;
        foreach (j; i..min(N, i+R)) {
            if (S[j] == '.') --r;
            S[j] = 'o';
        }
    }
    foreach (i; 0..N) {
        if (S[i] == '.') {
            paint(i);
        } else {
            int c;
            foreach (j; i..min(N, i+R)) if (S[j] == '.') ++c;
            if (r != 0 && c == r) paint(i);
        }
        if (r == 0) break;
        ++x;
    }
    writeln(x);
}