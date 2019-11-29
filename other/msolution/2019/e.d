import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^6+3;
long[10^^6+3] F, RF;

void init()
{
    F[0] = F[1] = 1;
    foreach (i, ref x; F[2..$]) x = (F[i+1] * (i+2)) % P;

    {
        RF[$-1] = 1;
        auto x = F[$-1];
        auto k = P-2;
        while (k) {
            if (k%2 == 1) RF[$-1] = (RF[$-1] * x) % P;
            x = x^^2 % P;
            k /= 2;
        }
    }
    foreach_reverse(i, ref x; RF[0..$-1]) x = (RF[i+1] * (i+1)) % P;
}

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    init();
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto xdn = readln.split.to!(long[]);
        auto x = xdn[0];
        auto d = xdn[1];
        auto n = xdn[2];

        if (x == 0) {
            writeln(0);
            continue;
        }

        if (d == 0) {
            writeln(pow(x, n));
            continue;
        }

        x = (x * pow(d, P-2)) % P;
        if (x == 0 || x+n-1 >= P) {
            writeln(0);
            continue;
        }
        auto xton = (F[x+n-1] * RF[x-1]) % P;
        
        writeln((pow(d, n) * xton) % P);
    }
}