import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    long solve(int i, long n, long s) {
        if (i == S.length) {
            return n + s;
        } else {
            return solve(i+1, S[i]-'0', n+s) + solve(i+1, n*10+S[i]-'0', s);
        }
    }
    writeln(solve(1, S[0]-'0', 0));
}