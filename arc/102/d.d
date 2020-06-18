import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto L = readln.chomp.to!int;

    if (L <= 60) {
        writeln(2, " ", L);
        foreach (l; 0..L) {
            writeln("1 2 ", l);
        }
        return;
    }

    int[] AS, BS, CS;

    int k, l = 1;
    while (l*2 <= L) {
        ++k;
        l *= 2;
    }
    int x = 1;
    foreach (_; 0..k) {
        l /= 2;
        AS ~= [x, x];
        BS ~= [x+1, x+1];
        CS ~= [l, 0];
        x += 1;
    }

    auto d = 2^^k;
    auto r = L - d;
    while (r) {
        if (r == 1) {
            AS ~= 1;
            BS ~= k+1;
            CS ~= L-1;
            break;
        }
        l = 2;
        foreach_reverse (y; 1..k+1) {
            if (l*2 > r) {
                AS ~= 1;
                BS ~= y;
                CS ~= d;
                r -= l;
                d += l;
                break;
            }
            l *= 2;
        }
    }

    writeln(k+1, " ", AS.length);
    foreach (i; 0..AS.length) writeln(AS[i], " ", BS[i], " ", CS[i]);
}