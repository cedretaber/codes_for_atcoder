import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    int s, n, r;
    size_t i;
    while (i < N*2) {
        if (i == N*2-1) break;
        if (S[i] != S[i+1]) {
            i += 2;
        } else {
            if (S[i] == '0') {
                if (s) {
                    --s;
                } else {
                    ++n;
                    ++r;
                }
            } else {
                if (n) {
                    --n;
                } else {
                    ++s;
                    ++r;
                }
            }
            i += 1;
        }
    }
    writeln(r);
}