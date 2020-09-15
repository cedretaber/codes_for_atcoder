import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;

    int r;
    void solve(string a, string b) {
        foreach (i; 0..a.length) {
            int rr;
            foreach (j; 0..b.length) {
                if (i+j == a.length) break;
                if (a[i+j] == b[j]) {
                    ++rr;
                    r = max(r, rr);
                } else {
                    rr = 0;
                }
            }
        }
    }
    solve(S, T);
    solve(T, S);
    writeln(r);
}