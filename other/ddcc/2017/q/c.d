import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nc = readln.split.to!(int[]);
    auto N = nc[0];
    long C = nc[1];
    auto LS = new long[](N);
    foreach (i; 0..N) LS[i] = readln.chomp.to!long;
    sort(LS);

    size_t i, j = N-1;
    int r;
    while (i <= j) {
        if (i == j) {
            ++r;
            break;
        }
        
        if (LS[i] + LS[j] + 1 > C) {
            ++r;
            --j;
        } else {
            ++r;
            ++i;
            --j;
        }
    }
    writeln(r);
}