import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool[10^^5+1] PS;

void prime_init()
{
    PS[] = true;
    PS[0] = false;
    PS[1] = false;
    foreach (i; 2..10^^5+1) {
        if (PS[i]) {
            auto x = i*2;
            while (x <= 10^^5) {
                PS[x] = false;
                x += i;
            }
        }
    }
}

void main()
{
    prime_init();
    auto qs = new int[](10^^5+1);
    foreach (i; 2..10^^5+1) if (PS[i] && PS[(i+1)/2]) qs[i] = 1;
    foreach (i; 0..10^^5) qs[i+1] += qs[i];

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto lr = readln.split.to!(int[]);
        writeln(qs[lr[1]] - qs[lr[0]-1]);
    }
}