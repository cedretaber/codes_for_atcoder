import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    foreach (k; 0..S.length) {
        bool ok = true;
        foreach (i; 0..S.length) {
            if (i >= k && S[i] != S[S.length-(i-k)-1]) {
                ok = false;
                break;
            }
        }
        if (ok) {
            writeln(k);
            return;
        }
    }
}