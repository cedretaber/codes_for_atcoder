import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;

    if (N%2 == 1 || N <= 10) {
        writeln(0);
    } else {
        long r;
        N /= 10;
        while (N) {
            r += N;
            N /= 5;
        }
        writeln(r);
    }
}