import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^6+1] F;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;

    foreach (i; 1..B+1) F[i] = (F[i-1] + i) % P;

    long b, a;
    foreach (i; 1..B+1) {
        b = (b + F[i] * i % P) % P;
        if (i == A-1) a = b;
    }
    writeln((b - a + P) % P);
}