import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nw = readln.split.to!(long[]);
    auto N = nw[0];
    auto W = nw[1];
    long[][4] vs;
    long base_w;
    foreach (i; 0..N) {
        auto wv = readln.split.to!(long[]);
        auto w = wv[0];
        auto v = wv[1];
        if (i == 0) {
            base_w = w;
        }
        vs[w - base_w] ~= v;
    }

    foreach (i; 0..4) {
        sort!"a > b"(vs[i]);
        vs[i] = [0L] ~ vs[i];
        foreach (j; 1..vs[i].length) vs[i][j] += vs[i][j-1];
    }

    long r;
    foreach (i; 0..vs[0].length) {
        foreach (j; 0..vs[1].length) {
            foreach (k; 0..vs[2].length) {
                foreach (l; 0..vs[3].length) {
                    if (i * base_w + j * (base_w+1) + k * (base_w+2) + l * (base_w+3) > W) continue;
                    r = max(r, vs[0][i] + vs[1][j] + vs[2][k] + vs[3][l]);
                }
            }
        }
    }
    writeln(r);
}