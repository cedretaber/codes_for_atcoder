import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto mk = readln.split.to!(uint[]);
    auto M = mk[0];
    auto K = mk[1];

    if (K == 0) {
        foreach (a; 0..2^^M-1) {
            write(a, " ");
            write(a, " ");
        }
        write(2^^M-1, " ");
        writeln(2^^M-1);
        return;
    }

    uint c;
    foreach (a; 1..2^^M) {
        if (a == K) continue;
        c ^= a;
    }

    if (c == K) {
        foreach (a; 0..2^^M) {
            if (a == K) continue;
            write(a, " ");
        }
        write(K, " ");
        foreach_reverse (a; 0..2^^M) {
            if (a == K) continue;
            write(a, " ");
        }
        writeln(K);
    } else {
        writeln("-1");
    }
}