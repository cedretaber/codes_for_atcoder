import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = "abcdefghij";
    char[] ss;
    ss.length = N;
    void solve(int i, int j) {
        if (i == N) {
            writeln(ss);
            return;
        }

        foreach (k; 0..j+2) {
            ss[i] = as[k];
            solve(i+1, max(j, k));
        }
    }

    solve(0, -1);
}