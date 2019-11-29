import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int[10^^5] CS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) CS[i] = readln.chomp.to!int;
    int s, last = CS[0], first_s, max_s = -1;
    foreach (c; CS[0..N]) {
        if (last == c) {
            ++s;
        } else if (max_s == -1) {
            max_s = s;
            if (CS[0] == CS[N-1]) first_s = s;
            s = 1;
            last = c;
        } else {
            max_s = max(max_s, s);
            s = 1;
            last = c;
        }
    }
    max_s = max(max_s, s + first_s);
    writeln(max_s == N ? -1 : (max_s - 1) / 2 + 1);
}