import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum A = "AKIHABARA";

void main()
{
    auto S = readln.chomp;
    size_t i, j;
    while (i < S.length && j < A.length) {
        if (S[i] == A[j]) {
            ++i; ++j;
        } else if (A[j] == 'A') {
            ++j;
        } else {
            writeln("NO");
            return;
        }
    }
    writeln((i == S.length && j >= A.length-1) ? "YES" : "NO");
}