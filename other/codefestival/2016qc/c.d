import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!int;
    auto ts = readln.split.to!(int[]);
    auto as = readln.split.to!(int[]);

    auto xs = new long[](N);
    foreach (i; 0..N) {
        if (i == 0 || ts[i] > ts[i-1]) {
            xs[i] = -ts[i];
        } else {
            xs[i] = ts[i];
        }
    }
    foreach_reverse (i; 0..N) {
        if (i == N-1 || as[i] > as[i+1]) {
            if (xs[i] == -as[i] || xs[i] >= as[i]) {
                xs[i] = -as[i];
            } else {
                writeln(0);
                return;
            }
        } else {
            xs[i] = min(xs[i], as[i]);
        }
    }
    auto r = 1L;
    foreach (x; xs) {
        r = (r * max(1, x)) % P;
    }
    writeln(r);
}