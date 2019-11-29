import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^5*2+50] F, RF;

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

void main()
{
    init();
    auto hwab = readln.split.to!(long[]);
    auto H = hwab[0];
    auto W = hwab[1];
    auto A = hwab[2];
    auto B = hwab[3];

    long r;

    auto free_h = H - A;
    auto free_w = W - B;
    foreach (y; 1..free_h+1) {
        auto m = ((F[B + y - 2] * RF[B-1])%P * RF[y-1])%P;
        auto o = ((F[free_w + (H-y) - 1] * RF[free_w-1])%P * RF[H-y])%P;
        r = (r + (m * o)%P)%P;
    }
    writeln(r);
}