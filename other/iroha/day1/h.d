import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    auto n = N;
    int s;
    while (n) {
        s += n%10;
        n /= 10;
    }
    int[] r;
    while (s > 9) {
        r ~= 9;
        s -= 9;
    }
    r ~= s;
    r = r.reverse;
    auto res = r.to!(string[]).join.to!long;
    if (res == N) {
        if (r.length > 1 && r[0] != 9) {
            r[0] += 1;
            r[1] -= 1;
        } else {
            r[0] -= 1;
            r = [1] ~ r;
        }
        res = r.to!(string[]).join.to!long;
    }
    writeln(res);
}