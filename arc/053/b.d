import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[26] C;

void main()
{
    auto S = readln.chomp;
    foreach (c; S) ++C[c-97];
    int n, s;
    foreach (c; C) {
        if (c%2 == 1) {
            ++n;
            s += c-1;
        } else {
            s += c;
        }
    }
    if (n == 0) {
        writeln(s);
        return;
    }
    int r;
    while (s >= n*2) {
        s -= n*2;
        r += 2;
    }
    writeln(r+1);
}