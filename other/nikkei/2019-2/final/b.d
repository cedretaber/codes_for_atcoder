import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp;
    long r;
    foreach (i; 1..S.length-3) {
        foreach (j; i+1..S.length-3) if (S[i..j] == S[S.length+i-j..$]) {
            int k = 1;
            while (j+k*2 < S.length+i-j) {
                if (S[j..j+k] == S[j+k..j+k*2]) ++r;
                ++k;
            }
        }
    }
    writeln(r);
}