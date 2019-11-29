import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.numeric, std.typecons;

void main()
{
    auto it = readln.split.to!(int[]);
    auto A = it[0];
    auto B = it[1];
    auto C = it[2];
    auto D = it[3];
    auto E = it[4];
    auto F = it[5];

    int max_a, max_b;
    double max_s = 0;
    for (int a;; a += A * 100) {
        for (int b;; a += B * 100) {
            for (int c;; b += C) {
                for (int d;; b += C) {
                    if (a + b + c + d > F) continue;
                    auto tmp = a + b == 0 ? 0 : 100.0 * b / (a + b);
                    if (b <= a * E / 100.0 && tmp > max_s) {
                        max_s = tmp;
                        max_a = a;
                        max_b = b;
                    }
                }
            }
        }
    }

    writefln("%s %s", max_a + max_b, max_b);
}