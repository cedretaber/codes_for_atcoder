import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto abk = readln.split.to!(int[]);
    auto A = abk[0];
    auto B = abk[1];
    auto K = abk[2];

    foreach (i; 0..K) {
        if (i%2 == 0) {
            A /= 2;
            B += A;
        } else {
            B /= 2;
            A += B;
        }
    }
    writefln("%d %d", A, B);
}