import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] T;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (b; 1..N) {
        auto a = readln.chomp.to!int - 1;
        T[a] ~= b;
    }

    int solve(int i) {
        int[] rr;
        foreach (j; T[i]) {
            rr ~= solve(j);
        }
        sort!"a > b"(rr);
        int max_r;
        foreach (j, r; rr) {
            max_r = max(max_r, r + j.to!int + 1);
        }
        return max_r;
    }
    writeln(solve(0));
}