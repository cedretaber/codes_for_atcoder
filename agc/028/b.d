import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^5+50] F, RF;

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

long[10^^5+1] MEMO, RN;

void main()
{
    init();
    
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    foreach (i; 0..N) RN[i+1] = (RF[i+1] * F[i]) % P;
    foreach (i; 0..N) MEMO[0] = (MEMO[0] + RN[i+1]) % P;

    for (int i = 2, j = N; i <= N; ++i, --j) {
        MEMO[i-1] = (MEMO[i-2] - RN[j] + RN[i]) % P;
        if (MEMO[i-1] < 0) MEMO[i-1] += P;
    }

    long r;
    foreach (i, a; AS) {
        r = (r + ((a * F[N]) % P * MEMO[i]) % P) % P;
    }

    writeln(r);
}