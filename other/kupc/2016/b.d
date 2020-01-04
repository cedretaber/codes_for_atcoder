import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[26] ps;
    foreach (_; 0..N) {
        ++ps[readln.chomp[0] - 'A'];
    }
    int solve() {
        int r;
        for (;;) {
            sort!"a > b"(ps[]);
            foreach (i; 0..K) {
                if (ps[i] == 0) return r;
                --ps[i];
            }
            ++r;
        }
    }
    writeln(solve());
}