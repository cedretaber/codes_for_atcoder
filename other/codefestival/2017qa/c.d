import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[26] CS;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    foreach (_; 0..H) {
        foreach (c; readln.chomp) ++CS[c - 'a'];
    }
    sort!"a > b"(CS[0..26]);
    size_t i;
    foreach (_y; 0..H/2) {
        foreach (_x; 0..W/2) {
            while (i < 26 && CS[i] < 4) ++i;
            if (i == 26) {
                writeln("No");
                return;
            }
            CS[i] -= 4;
        }
    }
    if (H%2 == 1) {
        i = 0;
        foreach (_x; 0..W/2) {
            while (i < 26 && CS[i] < 2) ++i;
            if (CS[i] < 2) {
                writeln("No");
                return;
            }
            CS[i] -= 2;
        }
    }
    if (W%2 == 1) {
        i = 0;
        foreach (_x; 0..H/2) {
            while (i < 26 && CS[i] < 2) ++i;
            if (i == 26) {
                writeln("No");
                return;
            }
            CS[i] -= 2;
        }
    }
    writeln("Yes");
}