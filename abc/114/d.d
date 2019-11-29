import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;

    int[] e;
    e.length = N+1;
    foreach (i; 2..N+1) {
        auto cur = i;
        foreach (j; 2..i+1) {
            while (cur % j == 0) {
                ++e[j];
                cur /= j;
            }
        }
    }

    int num(int m) {
        int cnt;
        foreach (x; e) {
            if (x >= m-1) ++cnt;
        }
        return cnt;
    }

    writeln(
        num(75) +
        num(25) * (num(3) - 1) +
        num(15) * (num(5) - 1) +
        num(5) * (num(5) - 1) * (num(3) - 2) / 2
    );
}