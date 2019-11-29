import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto abcd = readln.chomp.split("").to!(int[]);

    string[3] ret;
    bool solve(int i, int n) {
        if (i == 3 && n == 7) return true;
        if (i == 3) return false;
        ret[i] = "+";
        if (solve(i+1, n + abcd[i+1])) return true;
        ret[i] = "-";
        if(solve(i+1, n - abcd[i+1])) return true;
        return false;
    }
    solve(0, abcd[0]);

    writefln("%d%s%d%s%d%s%d=7", abcd[0], ret[0], abcd[1], ret[1], abcd[2], ret[2], abcd[3]);
}