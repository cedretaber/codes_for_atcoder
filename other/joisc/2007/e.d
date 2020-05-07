import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int pow(int x, int n, int p) {
    int y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % p;
        x = x^^2 % p;
        n /= 2;
    }
    return y;
}

void main()
{
    auto P = readln.chomp.to!int;
    auto N = readln.chomp.to!int;

    auto ps = new int[](P);
    foreach (p; 0..P) ++ps[pow(p, N, P)];
    int r;
    foreach (i; 0..P) {
        if (ps[i] == 0) continue;
        foreach (j; i..P) {
            r += ps[i] * ps[j] * ps[(i+j)%P] * (i == j ? 1 : 2);
        }
    }
    writeln(r);
}