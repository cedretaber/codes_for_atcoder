import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

int count_ds(int i)
{
    int r;
    while (i) {
        r += i%10;
        i /= 10;
    }
    return r;
}

void main()
{
    auto N = readln.chomp.to!int;

    int r = int.max;
    foreach (i; 1..N/2+1) {
        r = min(r, count_ds(i) + count_ds(N-i));
    }
    writeln(r);
}