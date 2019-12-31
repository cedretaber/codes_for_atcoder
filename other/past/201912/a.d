import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    foreach (i; 0..S.length) {
        if ('0' > S[i] || '9' < S[i]) {
            writeln("error");
            return;
        }
    }
    writeln(S.to!int * 2);
}