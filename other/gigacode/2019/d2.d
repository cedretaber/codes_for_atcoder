import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hwkv = readln.split.to!(long[]);
    auto H = hwkv[0];
    auto W = hwkv[1];
    auto K = hwkv[2];
    auto V = hwkv[3];

    auto MAP = new long[][](H+1, W+1);
    foreach (i; 1..H+1) {
        foreach (j, v; readln.split.to!(long[])) MAP[i][j+1] = v;
    }
    foreach (i; 1..H+1) {
        foreach (j; 1..W+1) {
            MAP[i][j] += MAP[i-1][j] + MAP[i][j-1] - MAP[i-1][j-1];
        }
    }

    long max_s;
    foreach (i; 1..H+1) {
        foreach (j; 1..W+1) {
            foreach (k; 0..i) {
                foreach (l; 0..j) {
                    auto s = (i-k) * (j-l);
                    auto v = s * K + MAP[i][j] - MAP[i][l] - MAP[k][j] + MAP[k][l];
                    if (v <= V) max_s = max(max_s, s);
                }
            }
        }
    }
    writeln(max_s);
}