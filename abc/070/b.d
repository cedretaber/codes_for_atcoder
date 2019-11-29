import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto abcd = readln.split.to!(int[]);
    auto a = abcd[0];
    auto b = abcd[1];
    auto c = abcd[2];
    auto d = abcd[3];

    if (b <= c || d <= a) {
        writeln(0);
    } else if (a <= c) {
        writeln(b < d ? b - c : d - c);
    } else {
        writeln(b < d ? b - a : d - a);
    }
}