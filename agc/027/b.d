import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];

    auto xs = readln.split.to!(long[]);

    BigInt[] cs;
    cs.length = N+1;
    foreach (i, x; xs) cs[i+1] = cs[i] + x;

    auto r = BigInt("10")^^30;
    foreach (k; 1..N+1) {
        BigInt s = N*X + k*X;
        foreach (j; 0..N/k+1) {
            s += (cs[N-j*k] - cs[max(0, N-(j+1)*k)]) * (j ? (2*(j+1)+1) : 5);
        }
        r = min(r, s);
    }

    writeln(r);
}