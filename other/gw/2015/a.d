import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ps = [25,39,51,76,163,111,0,128,133,138];
    int[] rs;
    void solve(int i, int p) {
        if (i == ps.length) {
            rs ~= p;
            return;
        }
        solve(i+1, p);
        if (i == 6) {
            solve(i+1, p + 58);
            solve(i+1, p + 136);
        } else {
            solve(i+1, p + ps[i]);
        }
    }
    solve(0, 0);
    sort(rs);
    foreach (r; rs.uniq()) writeln(r);
}