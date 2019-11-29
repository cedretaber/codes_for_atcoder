import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

// 0..900..1000..1100..2000
long[2000][901] L;

void main()
{
    auto rgb = readln.split.to!(int[]);
    auto R = rgb[0];
    auto G = rgb[1];
    auto B = rgb[2];

    foreach (i; 0..2000) {
        foreach (j; 0..R+G+B+1) {
            if (j == R+G+B) {
                L[j][i] = 0;
            } else if (i == 0) {
                L[j][i] = long.max/3;
            } else {
                long cost = j >= G+B ? abs(900 - i) : j >= B ? abs(1000 - i) : abs(1100 - i);
                L[j][i] = min(L[j][i-1], L[j+1][i-1] + cost);
            }
        }
    }
    writeln(L[0][$-1]);
}