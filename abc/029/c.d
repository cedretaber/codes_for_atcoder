import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    string[] r;
    
    void solve(int i, string s) {
        if (i == N) {
            r ~= s;
        } else {
            foreach (c; ["a", "b", "c"]) {
                solve(i+1, s~c);
            }
        }
    }
    solve(0, "");
    sort(r);
    foreach (l; r) writeln(l);
}