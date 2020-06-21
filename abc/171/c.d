import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    char[] res;
    while (N) {
        auto n = N % 26;
        if (n == 0) {
            n = 25;
            N -= 1;
        } else {
            n -= 1;
        }
        res ~= 'a' + n.to!char;
        N /= 26;
    }
    res.reverse();
    writeln(res);
}