import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!long;
    auto S = readln.chomp;
    long x, r = 1;
    foreach (c; S) {
        if (c == 'B') {
            if (x%2 == 0) {
                x += 1;
            } else {
                (r *= x) %= P;
                x -= 1;
            }
        } else {
            if (x%2 == 0) {
                (r *= x) %= P;
                x -= 1;
            } else {
                x += 1;
            }
        }
    }
    if (x != 0) {
        writeln(0);
        return;
    }

    foreach (long n; 1..N+1) (r *= n) %= P;
    writeln(r);
}