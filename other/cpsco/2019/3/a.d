import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    foreach (ref c; S) {
        if (c == 'O') c = 'A';
        else if (c == 'A') c = 'O';
    }
    writeln(S);
}