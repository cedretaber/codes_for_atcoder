import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nabcd = readln.split.to!(int[]);
    auto N = nabcd[0];
    auto A = nabcd[1]-1;
    auto B = nabcd[2]-1;
    auto C = nabcd[3]-1;
    auto D = nabcd[4]-1;
    auto S = readln.chomp.to!(char[]);
    auto len = S.length;

    if (D < C) {
        swap(A, B);
        swap(C, D);
    }

    bool moved;
    while (A != C || B != D) {
        if (B < D) {
            if (B+1 < len && S[B+1] != '#' && B+1 != A) {
                ++B;
                moved = true;
            } else if (B+2 < len && S[B+2] != '#' && B+2 != A) {
                B += 2;
                moved = true;
            }
        }
        if (A < C && !moved) {
            if (A+1 < len && S[A+1] != '#' && A+1 != B) {
                ++A;
                moved = true;
            } else if (A+2 < len && S[A+2] != '#' && A+1 != B && A+2 != B) {
                A += 2;
                moved = true;
            }
        }
        if (!moved) {
            writeln("No");
            return;
        }
        moved = false;
    }
    writeln("Yes");
}