import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias rsort = sort!("a > b", SwapStrategy.unstable, long[]);

void main()
{
    auto xyzk = readln.split.to!(int[]);
    auto X = xyzk[0];
    auto Y = xyzk[1];
    auto Z = xyzk[2];
    auto K = xyzk[3];
    auto AS = readln.split.to!(long[]);
    rsort(AS);
    auto BS = readln.split.to!(long[]);
    rsort(BS);
    auto CS = readln.split.to!(long[]);
    rsort(CS);

    long[] R;
    R.length = X * Y;
    int i;
    foreach (a; AS) {
        foreach (b; BS) {
            R[i++] = a + b;
        }
    }
    rsort(R);
    R = R[0..min($, 3000)];
    long[] S;
    S.length = Z * R.length;
    i = 0;
    foreach (r; R) {
        foreach (c; CS) {
            S[i++] = r + c;
        }
    }
    rsort(S);
    foreach (s; S[0..K]) writeln(s);
}