import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);
    foreach (_; 0..1000) {
        foreach_reverse (i; 1..S.length) {
            while (S[i-1] + A <= 'z' && S[i] >= 'a') {
                S[i-1] += A;
                --S[i];
            }
            if (S[i] == 'a'-1) S[i] = 0;
        }
    }
    char[] r;
    foreach (c; S) if (c != 0) r ~= c;
    writeln(r);
}